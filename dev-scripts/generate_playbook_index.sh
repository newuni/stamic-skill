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
      cat <<'EOF'
Generate a normalized index of playbooks and map status.

Usage:
  ./dev-scripts/generate_playbook_index.sh [--check] [--output <path>]

Options:
  --check          Do not write; fail if generated content differs from output file.
  --output <path>  Output markdown path (default: skills/stamic-skill/references/playbook-index.md)
EOF
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

status_line_re = re.compile(
    r"^\s*-\s*\[ \]\s*(?:\*\*)?(.*?)(?:\*\*)?\s*—\s*`(PENDING|DRAFTED|REFINED)(?:[^`]*)`(?:\s*—\s*(.*))?\s*$"
)
link_only_inline_re = re.compile(r"^\s*-\s*\[LINK_ONLY\].*?—\s*(https?://\S+)\s*$")
url_re = re.compile(r"https?://[^\s)`]+")


def normalize_url(url: str) -> str:
    return url.rstrip(").,;:").rstrip("/")


def parse_map(path: Path):
    lines = path.read_text(encoding="utf-8").splitlines()
    entries = []
    link_only_urls: set[str] = set()
    pending = None
    link_only_block = False

    for line_no, line in enumerate(lines, start=1):
        m_link_inline = link_only_inline_re.match(line)
        if m_link_inline:
            link_only_urls.add(normalize_url(m_link_inline.group(1)))
            pending = None
            continue

        if "[LINK_ONLY]" in line and line.strip().endswith(":"):
            link_only_block = True
            pending = None
            continue

        if link_only_block:
            block_urls = [normalize_url(u) for u in url_re.findall(line)]
            if line.strip().startswith("-") and block_urls:
                link_only_urls.update(block_urls)
                continue
            if not line.strip():
                continue
            link_only_block = False

        m = status_line_re.match(line)
        if m:
            title, status, rest = m.groups()
            inline_urls = [normalize_url(u) for u in url_re.findall(rest or "")]
            if inline_urls:
                entries.append(
                    {
                        "title": title.strip(),
                        "status": status,
                        "url": inline_urls[0],
                        "line": line_no,
                    }
                )
                pending = None
            else:
                pending = {"title": title.strip(), "status": status, "line": line_no}
            continue

        if pending is not None:
            followup_urls = [normalize_url(u) for u in url_re.findall(line)]
            if followup_urls:
                entries.append(
                    {
                        "title": pending["title"],
                        "status": pending["status"],
                        "url": followup_urls[0],
                        "line": pending["line"],
                    }
                )
                pending = None
                continue
            if line.startswith("## ") or line.startswith("---") or status_line_re.match(line):
                pending = None

    return entries, link_only_urls


def parse_playbooks(path: Path):
    rows = []
    for playbook in sorted(path.glob("*.md")):
        content = playbook.read_text(encoding="utf-8")
        first_line = content.splitlines()[0] if content else ""
        title = first_line[2:].strip() if first_line.startswith("# ") else playbook.stem
        urls = {normalize_url(u) for u in url_re.findall(content)}
        rows.append(
            {
                "slug": playbook.stem,
                "title": title,
                "urls": urls,
            }
        )
    return rows


entries, link_only_urls = parse_map(map_path)
playbooks = parse_playbooks(playbooks_dir)
status_by_url: dict[str, set[str]] = defaultdict(set)
for item in entries:
    status_by_url[item["url"]].add(item["status"])

ordered_status = {"PENDING": 0, "DRAFTED": 1, "REFINED": 2}
index_rows = []
for pb in playbooks:
    map_urls = sorted(pb["urls"] & set(status_by_url.keys()))
    link_urls = sorted(pb["urls"] & link_only_urls)

    if map_urls:
        statuses = sorted(
            {s for u in map_urls for s in status_by_url[u]},
            key=lambda s: ordered_status.get(s, -1),
        )
        status = statuses[-1]
        if len(statuses) > 1:
            status = f"{status}*"
        map_url = map_urls[0]
        note = ""
    elif link_urls:
        status = "LINK_ONLY"
        map_url = link_urls[0]
        note = "Only matches LINK_ONLY map URLs"
    else:
        status = "UNMAPPED"
        map_url = ""
        note = "No map URL match"

    index_rows.append(
        {
            "slug": pb["slug"],
            "title": pb["title"],
            "status": status,
            "map_url": map_url,
            "note": note,
        }
    )

counts = Counter(row["status"] for row in index_rows)

lines = []
lines.append("# Playbook Index")
lines.append("")
lines.append("Generated by `./dev-scripts/generate_playbook_index.sh`.")
lines.append("")
lines.append("Source files:")
lines.append("- `skills/stamic-skill/references/playbook-map.md`")
lines.append("- `skills/stamic-skill/references/playbooks/*.md`")
lines.append("")
lines.append("Status legend:")
lines.append("- `REFINED` / `DRAFTED` / `PENDING`: derived from map URLs.")
lines.append("- `REFINED*` / `DRAFTED*`: playbook URL matches map entries with mixed statuses.")
lines.append("- `LINK_ONLY`: only matches LINK_ONLY map URLs.")
lines.append("- `UNMAPPED`: no URL match in map.")
lines.append("")
lines.append("Counts:")
for key in sorted(counts.keys()):
    lines.append(f"- `{key}`: {counts[key]}")
lines.append("")
lines.append("| Slug | Title | Status | Map URL | Notes |")
lines.append("| --- | --- | --- | --- | --- |")
for row in index_rows:
    url_display = row["map_url"] if row["map_url"] else "-"
    note_display = row["note"] if row["note"] else "-"
    lines.append(
        f"| `{row['slug']}` | {row['title']} | `{row['status']}` | {url_display} | {note_display} |"
    )
lines.append("")

rendered = "\n".join(lines)

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
