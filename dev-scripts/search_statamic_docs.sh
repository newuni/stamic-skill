#!/usr/bin/env bash
set -euo pipefail

# Repo-level wrapper around the skill search script.
# Kept here so repo maintenance tools (like smoke tests) can call a stable path.

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
exec "$REPO_ROOT/skills/stamic-skill/scripts/search_statamic_docs.sh" "$@"
