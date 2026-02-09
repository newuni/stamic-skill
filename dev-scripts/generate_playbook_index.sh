#!/usr/bin/env bash
set -euo pipefail

# Generate a normalized index of playbooks and their map status.
#
# Usage:
#   ./dev-scripts/generate_playbook_index.sh
#   ./dev-scripts/generate_playbook_index.sh --check
#   ./dev-scripts/generate_playbook_index.sh --output <path>

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

CHECK_MODE=0
OUTPUT_PATH="skills/stamic-skill/references/playbook-index.md"

while [ $# -gt 0 ]; do
  case "$1" in
    --check)
      CHECK_MODE=1
      shift
      ;;
    --output)
      OUTPUT_PATH="${2:-}"
      if [ -z "$OUTPUT_PATH" ]; then
        echo "Missing value for --output" >&2
        exit 2
      fi
      shift 2
      ;;
    -h|--help)
      cat <<'USAGE'
Generate a normalized index of playbooks and map status.

Usage:
  ./dev-scripts/generate_playbook_index.sh [--check] [--output <path>]

Options:
  --check          Do not write; fail if generated content differs from output file.
  --output <path>  Output markdown path (default: skills/stamic-skill/references/playbook-index.md)
USAGE
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      exit 2
      ;;
  esac
done

python3 - "$CHECK_MODE" "$OUTPUT_PATH" <<'PY'
from __future__ import annotations

import re
import sys
from collections import Counter, defaultdict
from pathlib import Path

check_mode = bool(int(sys.argv[1]))
output_path = Path(sys.argv[2])
repo_root = Path.cwd()
map_path = repo_root / "skills/stamic-skill/references/playbook-map.md"
playbooks_dir = repo_root / "skills/stamic-skill/references/playbooks"

status_order = {"PENDING": 0, "DRAFTED": 1, "REFINED": 2}
status_line_re = re.compile(
    r"^\s*-\s*\[ \]\s*(?:\*\*)?(.*?)(?:\*\*)?\s*—\s*`(PENDING|DRAFTED|REFINED)(?:[^`]*)`(?:\s*—\s*(.*))?\s*$"
)
playbook_ref_re = re.compile(r"Playbook:\s*`references/playbooks/([^`]+)\.md`")
link_only_inline_re = re.compile(r"^\s*-\s*\[LINK_ONLY\].*?—\s*(https?://\S+)\s*$")
docs_line_re = re.compile(r"\bDocs:\s*(https?://\S+)")
url_re = re.compile(r"https?://[^\s)`]+")


def normalize_url(url: str) -> str:
    return url.rstrip(").,;:").rstrip("/")


def parse_map(path: Path):
    lines = path.read_text(encoding="utf-8").splitlines()
    entries = []
    link_only_urls: set[str] = set()
    current = None
    link_only_block = False

    def finish_current():
        nonlocal current
        if current is not None:
            entries.append(current)
            current = None

    for line_no, line in enumerate(lines, start=1):
        m_link_inline = link_only_inline_re.match(line)
        if m_link_inline:
            link_only_urls.add(normalize_url(m_link_inline.group(1)))
            continue

        if "[LINK_ONLY]" in line and line.strip().endswith(":"):
            link_only_block = True
            continue

        if link_only_block:
            block_urls = [normalize_url(u) for u in url_re.findall(line)]
            if line.strip().startswith("-") and block_urls:
                link_only_urls.update(block_urls)
                continue
            if not line.strip():
                continue
            link_only_block = False

        m_status = status_line_re.match(line)
        if m_status:
            finish_current()
            title, status, rest = m_status.groups()
            inline_urls = [normalize_url(u) for u in url_re.findall(rest or "")]
            current = {
                "title": title.strip(),
                "status": status,
                "line": line_no,
                "url": inline_urls[0] if inline_urls else None,
                "playbook_slug": None,
            }
            continue

        if current is None:
            continue

        if line.startswith("## ") or line.startswith("---"):
            finish_current()
            continue

        m_playbook = playbook_ref_re.search(line)
        if m_playbook:
            current["playbook_slug"] = m_playbook.group(1)

        if current["url"] is None:
            m_docs = docs_line_re.search(line)
            if m_docs:
                current["url"] = normalize_url(m_docs.group(1))

    finish_current()
    return entries, link_only_urls


def parse_playbooks(path: Path):
    rows = []
    for playbook in sorted(path.glob("*.md")):
        content = playbook.read_text(encoding="utf-8")
        lines = content.splitlines()
        first_line = lines[0] if lines else ""
        title = first_line[2:].strip() if first_line.startswith("# ") else playbook.stem

        urls_all = [normalize_url(u) for u in url_re.findall(content)]
        seen = set()
        urls = []
        for u in urls_all:
            if u not in seen:
                seen.add(u)
                urls.append(u)

        source_urls = []
        in_sources = False
        for line in lines:
            if line.strip().startswith("## "):
                in_sources = line.strip() == "## Sources"
                continue
            if not in_sources:
                continue
            for u in [normalize_url(x) for x in url_re.findall(line)]:
                if u not in source_urls:
                    source_urls.append(u)

        rows.append(
            {
                "slug": playbook.stem,
                "title": title,
                "urls": urls,
                "source_urls": source_urls,
            }
        )
    return rows


def highest_status(statuses):
    return sorted(statuses, key=lambda s: status_order[s])[-1]


entries, link_only_urls = parse_map(map_path)
playbooks = parse_playbooks(playbooks_dir)

entries_by_slug = defaultdict(list)
entries_by_url = defaultdict(list)
for entry in entries:
    if entry.get("playbook_slug"):
        entries_by_slug[entry["playbook_slug"]].append(entry)
    if entry.get("url"):
        entries_by_url[entry["url"]].append(entry)

rows = []
for pb in playbooks:
    notes = []
    selected_status = None
    selected_match = "-"

    explicit = entries_by_slug.get(pb["slug"], [])
    if explicit:
        explicit_sorted = sorted(explicit, key=lambda e: (status_order[e["status"]], -e["line"]))
        selected = explicit_sorted[-1]
        selected_status = selected["status"]
        selected_match = f"playbook:{pb['slug']}"
        explicit_statuses = {e["status"] for e in explicit}
        if len(explicit_statuses) > 1:
            notes.append(
                "Mixed explicit statuses: " + ", ".join(sorted(explicit_statuses, key=lambda s: status_order[s]))
            )
    else:
        candidate_urls = []
        for u in pb["source_urls"] + pb["urls"]:
            if u in entries_by_url and u not in candidate_urls:
                candidate_urls.append(u)

        if candidate_urls:
            selected_url = candidate_urls[0]
            selected_match = selected_url
            selected_statuses = {e["status"] for e in entries_by_url[selected_url]}
            selected_status = highest_status(selected_statuses)
            if len(selected_statuses) > 1:
                notes.append(
                    "Mixed map statuses for selected URL: "
                    + ", ".join(sorted(selected_statuses, key=lambda s: status_order[s]))
                )
            if len(candidate_urls) > 1:
                notes.append("Additional URL matches: " + ", ".join(candidate_urls[1:]))
        else:
            link_candidates = []
            for u in pb["source_urls"] + pb["urls"]:
                if u in link_only_urls and u not in link_candidates:
                    link_candidates.append(u)
            if link_candidates:
                selected_status = "LINK_ONLY"
                selected_match = link_candidates[0]
                if len(link_candidates) > 1:
                    notes.append("Additional LINK_ONLY matches: " + ", ".join(link_candidates[1:]))
            else:
                selected_status = "UNMAPPED"

    rows.append(
        {
            "slug": pb["slug"],
            "title": pb["title"],
            "status": selected_status,
            "map_match": selected_match,
            "notes": "; ".join(notes) if notes else "-",
        }
    )

rows.sort(key=lambda r: r["slug"])
counts = Counter(r["status"] for r in rows)

md = []
md.append("# Playbook Index")
md.append("")
md.append("Generated by `./dev-scripts/generate_playbook_index.sh`.")
md.append("")
md.append("Source files:")
md.append("- `skills/stamic-skill/references/playbook-map.md`")
md.append("- `skills/stamic-skill/references/playbooks/*.md`")
md.append("")
md.append("Status legend:")
md.append("- `REFINED` / `DRAFTED` / `PENDING`: mapped from `playbook-map.md` status entries.")
md.append("- `LINK_ONLY`: only matches LINK_ONLY map URLs.")
md.append("- `UNMAPPED`: no map URL/Playbook match found.")
md.append("")
md.append("Counts:")
for key in sorted(counts.keys(), key=lambda k: (k not in status_order, status_order.get(k, 99), k)):
    md.append(f"- `{key}`: {counts[key]}")
md.append("")
md.append("| Slug | Title | Status | Map Match | Notes |")
md.append("| --- | --- | --- | --- | --- |")
for r in rows:
    md.append(
        f"| `{r['slug']}` | {r['title']} | `{r['status']}` | {r['map_match']} | {r['notes']} |"
    )
md.append("")

rendered = "\n".join(md)

if check_mode:
    current = output_path.read_text(encoding="utf-8") if output_path.exists() else ""
    if current != rendered:
        print(f"[fail] {output_path} is out of date. Run ./dev-scripts/generate_playbook_index.sh")
        sys.exit(1)
    print(f"[ok] {output_path} is up to date")
    sys.exit(0)

output_path.parent.mkdir(parents=True, exist_ok=True)
output_path.write_text(rendered, encoding="utf-8")
print(f"[ok] wrote {output_path}")
PY
