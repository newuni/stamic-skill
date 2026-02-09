#!/usr/bin/env bash
set -euo pipefail

# Update (clone/pull) the Statamic docs mirror for this repository.
# Wrapper around the runtime skill script so behavior stays identical.
#
# Usage:
#   ./dev-scripts/update_statamic_docs.sh
#   ./dev-scripts/update_statamic_docs.sh --docs-dir <target_dir>
#   ./dev-scripts/update_statamic_docs.sh <target_dir>
#
# Defaults:
#   <repo-root>/skills/.cache/statamic-docs

usage() {
  cat <<'EOF'
Update (clone/pull) the Statamic docs mirror.

Usage:
  ./dev-scripts/update_statamic_docs.sh [--docs-dir <path>]
  ./dev-scripts/update_statamic_docs.sh [<path>]

Defaults:
  <repo-root>/skills/.cache/statamic-docs
EOF
}

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CACHE_DIR_DEFAULT="$REPO_ROOT/skills/.cache/statamic-docs"
RUNTIME_SCRIPT="$REPO_ROOT/skills/stamic-skill/scripts/update_statamic_docs.sh"

if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
  usage
  exit 0
fi

if [ ! -x "$RUNTIME_SCRIPT" ]; then
  echo "Runtime script not found or not executable: $RUNTIME_SCRIPT" >&2
  exit 2
fi

if [ "${1:-}" = "--docs-dir" ]; then
  exec "$RUNTIME_SCRIPT" --docs-dir "${2:-}"
elif [ -n "${1:-}" ]; then
  exec "$RUNTIME_SCRIPT" --docs-dir "$1"
else
  exec "$RUNTIME_SCRIPT" --docs-dir "$CACHE_DIR_DEFAULT"
fi
