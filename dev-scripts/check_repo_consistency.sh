#!/usr/bin/env bash
set -euo pipefail

# Validate docs/script consistency for this repository.
#
# Checks:
# - required scripts exist
# - no stale references to removed script paths
# - SKILL metadata version matches top version in changelogs
#
# Usage:
#   ./dev-scripts/check_repo_consistency.sh

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

fail=0

ok() {
  echo "[ok] $1"
}

err() {
  echo "[fail] $1" >&2
  fail=1
}

check_exists() {
  local path="$1"
  if [ -f "$path" ]; then
    ok "exists: $path"
  else
    err "missing file: $path"
  fi
}

check_exists "dev-scripts/update_statamic_docs.sh"
check_exists "dev-scripts/search_statamic_docs.sh"
check_exists "dev-scripts/smoke_statamic_docs.sh"
check_exists "skills/stamic-skill/scripts/search_statamic_docs.sh"

if rg -n "\\./scripts/update_statamic_docs\\.sh" \
  README.md \
  skills/stamic-skill/README.md \
  skills/stamic-skill/SKILL.md >/dev/null; then
  err "stale reference found: ./scripts/update_statamic_docs.sh"
else
  ok "no stale references to removed update script path"
fi

skill_version="$(sed -n 's/^  version: "\(.*\)"/\1/p' skills/stamic-skill/SKILL.md | head -n 1)"
root_changelog_version="$(awk '/^## / {print $2; exit}' CHANGELOG.md)"
skill_changelog_version="$(awk '/^## / {print $2; exit}' skills/stamic-skill/CHANGELOG.md)"

if [ -z "$skill_version" ]; then
  err "could not parse metadata version from skills/stamic-skill/SKILL.md"
else
  ok "metadata version: $skill_version"
fi

if [ -z "$root_changelog_version" ]; then
  err "could not parse top version from CHANGELOG.md"
fi

if [ -z "$skill_changelog_version" ]; then
  err "could not parse top version from skills/stamic-skill/CHANGELOG.md"
fi

if [ -n "$skill_version" ] && [ -n "$root_changelog_version" ] && [ "$skill_version" != "$root_changelog_version" ]; then
  err "version mismatch: SKILL.md=$skill_version, CHANGELOG.md=$root_changelog_version"
else
  ok "SKILL.md and CHANGELOG.md versions match"
fi

if [ -n "$skill_version" ] && [ -n "$skill_changelog_version" ] && [ "$skill_version" != "$skill_changelog_version" ]; then
  err "version mismatch: SKILL.md=$skill_version, skills/stamic-skill/CHANGELOG.md=$skill_changelog_version"
else
  ok "SKILL.md and skills/stamic-skill/CHANGELOG.md versions match"
fi

if [ "$fail" -ne 0 ]; then
  echo "[check] FAILED" >&2
  exit 1
fi

echo "[check] OK"
