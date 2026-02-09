#!/usr/bin/env bash
set -euo pipefail

# Keep a local clone of https://github.com/statamic/docs for fast, offline-ish search.
#
# Usage:
#   ./scripts/update_statamic_docs.sh [<target_dir>]
#
# Environment:
#   STATAMIC_DOCS_DIR  Override default target dir

usage() {
  cat <<'EOF'
Update (clone/pull) the Statamic docs mirror.

Usage:
  ./scripts/update_statamic_docs.sh [<target_dir>]

Defaults:
  <skill-root>/.cache/statamic-docs

Environment:
  STATAMIC_DOCS_DIR  Override default target dir
EOF
}

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
CACHE_DIR_DEFAULT="$ROOT_DIR/.cache/statamic-docs"
TARGET_DIR="${1:-${STATAMIC_DOCS_DIR:-$CACHE_DIR_DEFAULT}}"

if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
  usage
  exit 0
fi

if [ -e "$TARGET_DIR" ] && [ ! -d "$TARGET_DIR" ]; then
  echo "Target exists but is not a directory: $TARGET_DIR" >&2
  exit 2
fi

if [ -d "$TARGET_DIR/.git" ]; then
  echo "[statamic-docs] Updating: $TARGET_DIR"
  git -C "$TARGET_DIR" fetch --all --prune
  git -C "$TARGET_DIR" pull --ff-only
else
  echo "[statamic-docs] Cloning into: $TARGET_DIR"
  mkdir -p "$TARGET_DIR"
  # If the directory exists and is non-empty but not a git repo, fail explicitly.
  if [ -n "$(ls -A "$TARGET_DIR" 2>/dev/null || true)" ]; then
    echo "Target dir is not empty and not a git repo: $TARGET_DIR" >&2
    exit 2
  fi
  git clone --depth 1 https://github.com/statamic/docs "$TARGET_DIR"
fi

echo "[statamic-docs] Current HEAD: $(git -C "$TARGET_DIR" rev-parse --short HEAD)"
