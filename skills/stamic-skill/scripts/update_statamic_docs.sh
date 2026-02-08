#!/usr/bin/env bash
set -euo pipefail

# Keep a local clone of https://github.com/statamic/docs for fast, offline-ish search.
# Usage:
#   ./scripts/update_statamic_docs.sh [<target_dir>]

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
CACHE_DIR_DEFAULT="$ROOT_DIR/.cache/statamic-docs"
TARGET_DIR="${1:-$CACHE_DIR_DEFAULT}"

if [ -d "$TARGET_DIR/.git" ]; then
  echo "[statamic-docs] Updating: $TARGET_DIR"
  git -C "$TARGET_DIR" fetch --all --prune
  git -C "$TARGET_DIR" pull --ff-only
else
  echo "[statamic-docs] Cloning into: $TARGET_DIR"
  mkdir -p "$(dirname "$TARGET_DIR")"
  git clone --depth 1 https://github.com/statamic/docs "$TARGET_DIR"
fi

echo "[statamic-docs] Current HEAD: $(git -C "$TARGET_DIR" rev-parse --short HEAD)"
