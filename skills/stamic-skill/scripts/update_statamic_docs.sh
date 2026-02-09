#!/usr/bin/env bash
set -euo pipefail

# Update (clone/pull) a local mirror of https://github.com/statamic/docs.
# This script is bundled with the skill so installed copies can bootstrap docs lookup.
#
# Usage:
#   ./scripts/update_statamic_docs.sh
#   ./scripts/update_statamic_docs.sh --docs-dir /path/to/statamic-docs
#   ./scripts/update_statamic_docs.sh /path/to/statamic-docs

usage() {
  cat <<'EOF'
Update (clone/pull) the Statamic docs mirror.

Usage:
  ./scripts/update_statamic_docs.sh [--docs-dir <path>]
  ./scripts/update_statamic_docs.sh [<path>]

Defaults:
  <skills-root>/.cache/statamic-docs
EOF
}

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
DOCS_DIR_DEFAULT="$ROOT_DIR/.cache/statamic-docs"
TARGET_DIR="$DOCS_DIR_DEFAULT"

if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
  usage
  exit 0
fi

if [ "${1:-}" = "--docs-dir" ]; then
  TARGET_DIR="${2:-}"
  if [ -z "$TARGET_DIR" ]; then
    echo "Missing value for --docs-dir" >&2
    exit 2
  fi
elif [ -n "${1:-}" ]; then
  TARGET_DIR="$1"
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
  if [ -n "$(ls -A "$TARGET_DIR" 2>/dev/null || true)" ]; then
    echo "Target dir is not empty and not a git repo: $TARGET_DIR" >&2
    exit 2
  fi
  git clone --depth 1 https://github.com/statamic/docs "$TARGET_DIR"
fi

echo "[statamic-docs] Current HEAD: $(git -C "$TARGET_DIR" rev-parse --short HEAD)"
