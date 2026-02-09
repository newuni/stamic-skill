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
LOCK_TIMEOUT_SECONDS="${STATAMIC_DOCS_LOCK_TIMEOUT_SECONDS:-180}"
LOCK_STALE_SECONDS="${STATAMIC_DOCS_LOCK_STALE_SECONDS:-900}"
LOCK_POLL_SECONDS="${STATAMIC_DOCS_LOCK_POLL_SECONDS:-1}"
LOCK_DIR=""
LOCK_ACQUIRED=0
TMP_CLONE_DIR=""

cleanup() {
  if [ -n "$TMP_CLONE_DIR" ] && [ -d "$TMP_CLONE_DIR" ]; then
    rm -rf "$TMP_CLONE_DIR" || true
  fi
  if [ "$LOCK_ACQUIRED" = "1" ] && [ -n "$LOCK_DIR" ] && [ -d "$LOCK_DIR" ]; then
    rm -rf "$LOCK_DIR" || true
  fi
}

trap cleanup EXIT INT TERM

lock_pid() {
  cat "$LOCK_DIR/pid" 2>/dev/null || true
}

lock_created_at() {
  cat "$LOCK_DIR/created_at" 2>/dev/null || true
}

is_process_alive() {
  local pid="$1"
  if [[ ! "$pid" =~ ^[0-9]+$ ]]; then
    return 1
  fi
  ps -p "$pid" >/dev/null 2>&1
}

lock_age_seconds() {
  local created_at="$1"
  local now
  now="$(date +%s)"
  if [[ "$created_at" =~ ^[0-9]+$ ]]; then
    echo $((now - created_at))
  else
    echo "-1"
  fi
}

acquire_lock() {
  local start now waited pid created_at age
  start="$(date +%s)"

  while true; do
    if mkdir "$LOCK_DIR" 2>/dev/null; then
      printf '%s\n' "$$" > "$LOCK_DIR/pid"
      date +%s > "$LOCK_DIR/created_at"
      LOCK_ACQUIRED=1
      return 0
    fi

    pid="$(lock_pid)"
    created_at="$(lock_created_at)"
    age="$(lock_age_seconds "$created_at")"
    if [ "$age" -ge "$LOCK_STALE_SECONDS" ] && { [ -z "$pid" ] || ! is_process_alive "$pid"; }; then
      echo "[statamic-docs] Removing stale lock: $LOCK_DIR (pid=${pid:-unknown}, age=${age}s)"
      rm -rf "$LOCK_DIR" || true
      continue
    fi

    now="$(date +%s)"
    waited=$((now - start))
    if [ "$waited" -ge "$LOCK_TIMEOUT_SECONDS" ]; then
      echo "Timeout waiting for docs mirror lock ($LOCK_DIR) after ${waited}s." >&2
      exit 2
    fi

    sleep "$LOCK_POLL_SECONDS"
  done
}

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

LOCK_DIR="${TARGET_DIR}.lock"
acquire_lock

if [ -d "$TARGET_DIR/.git" ]; then
  echo "[statamic-docs] Updating: $TARGET_DIR"
  git -C "$TARGET_DIR" fetch --all --prune
  git -C "$TARGET_DIR" pull --ff-only
else
  if [ -d "$TARGET_DIR" ] && [ -n "$(ls -A "$TARGET_DIR" 2>/dev/null || true)" ]; then
    echo "Target dir is not empty and not a git repo: $TARGET_DIR" >&2
    exit 2
  fi

  echo "[statamic-docs] Cloning into: $TARGET_DIR (atomic mode)"
  mkdir -p "$(dirname "$TARGET_DIR")"
  TMP_CLONE_DIR="$(dirname "$TARGET_DIR")/.statamic-docs.tmp.$$.$RANDOM"
  git clone --depth 1 https://github.com/statamic/docs "$TMP_CLONE_DIR"

  if [ -d "$TARGET_DIR" ]; then
    rmdir "$TARGET_DIR" 2>/dev/null || true
  fi

  if [ -e "$TARGET_DIR" ]; then
    echo "Target became unavailable during clone (already exists): $TARGET_DIR" >&2
    exit 2
  fi

  mv "$TMP_CLONE_DIR" "$TARGET_DIR"
  TMP_CLONE_DIR=""
fi

echo "[statamic-docs] Current HEAD: $(git -C "$TARGET_DIR" rev-parse --short HEAD)"
