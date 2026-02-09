#!/usr/bin/env bash
set -euo pipefail

# Validate map <-> playbook synchronization.
#
# Usage:
#   ./dev-scripts/check_playbook_sync.sh

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

python3 - <<'PY'
from __future__ import annotations

import re
import subprocess
import sys
from collections import defaultdict
from pathlib import Path

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
    rows = {}
    for playbook in sorted(path.glob("*.md")):
        content = playbook.read_text(encoding="utf-8")
        lines = content.splitlines()
        title = lines[0][2:].strip() if lines and lines[0].startswith("# ") else playbook.stem
        urls = {normalize_url(u) for u in url_re.findall(content)}
        rows[playbook.stem] = {
            "title": title,
            "urls": urls,
            "content": content,
        }
    return rows


entries, link_only_urls = parse_map(map_path)
playbooks = parse_playbooks(playbooks_dir)

entries_by_url = defaultdict(list)
entries_by_slug = defaultdict(list)
for e in entries:
    if e.get("url"):
        entries_by_url[e["url"]].append(e)
    if e.get("playbook_slug"):
        entries_by_slug[e["playbook_slug"]].append(e)

playbooks_by_url = defaultdict(set)
for slug, meta in playbooks.items():
    for url in meta["urls"]:
        playbooks_by_url[url].add(slug)

errors: list[str] = []

# 0) Structural quality checks inside playbooks.
required_markers = ["**Summary:**", "## Steps", "## Sources"]
for slug, meta in sorted(playbooks.items()):
    missing = [m for m in required_markers if m not in meta["content"]]
    if missing:
        errors.append(f"playbook `{slug}` is missing required sections: {', '.join(missing)}")

# 0b) Duplicate H1 titles are disallowed.
titles = defaultdict(list)
for slug, meta in playbooks.items():
    titles[meta["title"]].append(slug)
for title, slugs in sorted(titles.items()):
    if len(slugs) > 1:
        errors.append(f"duplicate playbook title `{title}` used by: {', '.join(sorted(slugs))}")

# 1) Every playbook must map by explicit slug or by URL/link-only.
map_urls = set(entries_by_url.keys())
for slug, meta in sorted(playbooks.items()):
    has_explicit = slug in entries_by_slug
    has_url = bool(meta["urls"] & map_urls)
    has_link_only = bool(meta["urls"] & link_only_urls)
    if not (has_explicit or has_url or has_link_only):
        errors.append(f"playbook `{slug}` has no map match (explicit/playbook URL/LINK_ONLY)")

# 2) Every DRAFTED/REFINED map entry must have a playbook match.
for entry in entries:
    if entry["status"] not in {"DRAFTED", "REFINED"}:
        continue
    slug = entry.get("playbook_slug")
    if slug:
        if slug not in playbooks:
            errors.append(f"map entry line {entry['line']} references missing playbook slug `{slug}`")
        continue

    url = entry.get("url")
    if url and not playbooks_by_url.get(url):
        errors.append(f"map URL `{url}` ({entry['status']}) has no matching playbook")
    if not slug and not url:
        errors.append(
            f"map entry line {entry['line']} ({entry['status']}) must define Docs URL or Playbook reference"
        )

# 3) PENDING URL entries should not already be covered by playbooks.
for entry in entries:
    if entry["status"] != "PENDING":
        continue
    url = entry.get("url")
    if not url:
        continue
    matched = sorted(playbooks_by_url.get(url, []))
    if matched:
        errors.append(f"map URL `{url}` is PENDING but already matched by playbooks: {', '.join(matched)}")

# 4) Same URL cannot mix PENDING and non-PENDING statuses.
statuses_by_url = defaultdict(set)
for e in entries:
    if e.get("url"):
        statuses_by_url[e["url"]].add(e["status"])
for url, statuses in sorted(statuses_by_url.items()):
    if "PENDING" in statuses and (statuses & {"DRAFTED", "REFINED"}):
        ordered = sorted(statuses, key=lambda s: status_order[s])
        errors.append(f"map URL `{url}` has mixed statuses including PENDING: {ordered}")

# 4b) DRAFTED is disallowed in the cleaned map.
if any(e["status"] == "DRAFTED" for e in entries):
    errors.append("playbook-map.md contains `DRAFTED` entries; use `REFINED` or `PENDING` only")

# 5) Generated index must be up-to-date.
result = subprocess.run(
    ["./dev-scripts/generate_playbook_index.sh", "--check"],
    cwd=repo_root,
    text=True,
    capture_output=True,
)
if result.returncode != 0:
    msg = result.stdout.strip() or result.stderr.strip() or "playbook index out of date"
    errors.append(msg)

if errors:
    for err in errors:
        print(f"[fail] {err}")
    print(f"[check] FAILED ({len(errors)} issue(s))")
    sys.exit(1)

print("[check] OK")
PY
