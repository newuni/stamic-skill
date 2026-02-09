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
    playbooks = {}
    for playbook in sorted(path.glob("*.md")):
        content = playbook.read_text(encoding="utf-8")
        urls = {normalize_url(u) for u in url_re.findall(content)}
        playbooks[playbook.stem] = urls
    return playbooks


entries, link_only_urls = parse_map(map_path)
playbooks = parse_playbooks(playbooks_dir)

map_by_url: dict[str, list[dict]] = defaultdict(list)
for entry in entries:
    map_by_url[entry["url"]].append(entry)

playbooks_by_url: dict[str, set[str]] = defaultdict(set)
for slug, urls in playbooks.items():
    for url in urls:
        playbooks_by_url[url].add(slug)

errors: list[str] = []

# 1) Every playbook must match at least one map URL (status URL or LINK_ONLY URL).
for slug, urls in sorted(playbooks.items()):
    if not (urls & set(map_by_url.keys()) or urls & link_only_urls):
        errors.append(f"playbook `{slug}` has no URL match in playbook-map.md")

# 2) DRAFTED/REFINED entries with URL must have at least one playbook.
for url, url_entries in sorted(map_by_url.items()):
    statuses = {entry["status"] for entry in url_entries}
    has_playbook = bool(playbooks_by_url.get(url))
    if statuses & {"DRAFTED", "REFINED"} and not has_playbook:
        labels = ", ".join(sorted(statuses))
        errors.append(f"map URL `{url}` ({labels}) has no matching playbook")

# 3) PENDING entries with URL should not have matching playbooks.
for url, url_entries in sorted(map_by_url.items()):
    statuses = {entry["status"] for entry in url_entries}
    matched = sorted(playbooks_by_url.get(url, []))
    if "PENDING" in statuses and matched:
        errors.append(
            f"map URL `{url}` is PENDING but already matched by playbooks: {', '.join(matched)}"
        )

# 4) Incoherent status if same URL has both PENDING and non-PENDING.
for url, url_entries in sorted(map_by_url.items()):
    statuses = {entry["status"] for entry in url_entries}
    if "PENDING" in statuses and (statuses & {"DRAFTED", "REFINED"}):
        errors.append(f"map URL `{url}` has mixed statuses including PENDING: {sorted(statuses)}")

# 5) Generated index must be up to date.
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
