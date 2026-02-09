#!/usr/bin/env bash
set -euo pipefail

# Search a local clone of https://github.com/statamic/docs.
# Designed to be usable by agents:
# - no interactivity
# - stable, line-oriented output
# - predictable options via --help

usage() {
  cat <<'EOF'
Search Statamic docs (local mirror).

Usage:
  ./scripts/search_statamic_docs.sh [--docs-dir <path>] [--ignore-case] [--context <N>] [--top <N>] [--no-bootstrap] [--wait-timeout <N>] <query>

Options:
  --docs-dir <path>   Docs mirror path (default: <skill-root>/.cache/statamic-docs)
  --ignore-case, -i   Case-insensitive search
  --context <N>       Show N lines of context (default: 0)
  --top <N>           Limit to N result lines (default: unlimited)
  --no-bootstrap      Do not auto-clone docs mirror when missing
  --wait-timeout <N>  Max seconds to wait for an update lock (default: 120)
  -h, --help          Show this help

Output:
  A grep/rg-style stream of lines: path:line:match

Notes:
  - Prefers ripgrep (rg) if installed; falls back to grep.
  - Auto-bootstraps the mirror on first run unless --no-bootstrap is set.
  - Waits for in-progress mirror updates before searching.
  - To bootstrap/update manually, run: ./scripts/update_statamic_docs.sh
EOF
}

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
DOCS_DIR_DEFAULT="$ROOT_DIR/.cache/statamic-docs"
DOCS_DIR="$DOCS_DIR_DEFAULT"
CONTEXT=0
IGNORE_CASE=0
TOP=""
AUTO_BOOTSTRAP=1
WAIT_TIMEOUT_SECONDS="${STATAMIC_DOCS_SEARCH_WAIT_TIMEOUT_SECONDS:-120}"
LOCK_STALE_SECONDS="${STATAMIC_DOCS_LOCK_STALE_SECONDS:-900}"

# Parse options
while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help)
      usage
      exit 0
      ;;
    --docs-dir)
      DOCS_DIR="${2:-}"
      if [ -z "$DOCS_DIR" ]; then
        echo "Missing value for --docs-dir" >&2
        exit 2
      fi
      shift 2
      ;;
    --context)
      CONTEXT="${2:-}"
      if [ -z "$CONTEXT" ]; then
        echo "Missing value for --context" >&2
        exit 2
      fi
      shift 2
      ;;
    --top)
      TOP="${2:-}"
      if [ -z "$TOP" ]; then
        echo "Missing value for --top" >&2
        exit 2
      fi
      shift 2
      ;;
    --wait-timeout)
      WAIT_TIMEOUT_SECONDS="${2:-}"
      if [ -z "$WAIT_TIMEOUT_SECONDS" ]; then
        echo "Missing value for --wait-timeout" >&2
        exit 2
      fi
      shift 2
      ;;
    --no-bootstrap)
      AUTO_BOOTSTRAP=0
      shift
      ;;
    -i|--ignore-case)
      IGNORE_CASE=1
      shift
      ;;
    --)
      shift
      break
      ;;
    *)
      break
      ;;
  esac
done

QUERY="${1:-}"
if [ -z "$QUERY" ]; then
  echo "Missing query." >&2
  usage >&2
  exit 2
fi

if [ ! -d "$DOCS_DIR" ]; then
  if [ "$AUTO_BOOTSTRAP" = "1" ]; then
    echo "Docs not found at: $DOCS_DIR" >&2
    echo "Bootstrapping local mirror..." >&2
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    "$SCRIPT_DIR/update_statamic_docs.sh" --docs-dir "$DOCS_DIR"
  else
    echo "Docs not found at: $DOCS_DIR" >&2
    echo "This script requires a local mirror of github.com/statamic/docs." >&2
    echo "Run: ./scripts/update_statamic_docs.sh --docs-dir \"$DOCS_DIR\"" >&2
    exit 2
  fi
fi

if [ ! -d "$DOCS_DIR" ]; then
  echo "Docs bootstrap failed. Mirror still missing at: $DOCS_DIR" >&2
  exit 2
fi

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

wait_for_update_lock() {
  local start now waited pid created_at age
  start="$(date +%s)"

  while [ -d "$LOCK_DIR" ]; do
    pid="$(lock_pid)"
    created_at="$(lock_created_at)"
    age="$(lock_age_seconds "$created_at")"
    if [ "$age" -ge "$LOCK_STALE_SECONDS" ] && { [ -z "$pid" ] || ! is_process_alive "$pid"; }; then
      echo "[statamic-docs] Removing stale search lock: $LOCK_DIR (pid=${pid:-unknown}, age=${age}s)" >&2
      rm -rf "$LOCK_DIR" || true
      continue
    fi

    now="$(date +%s)"
    waited=$((now - start))
    if [ "$waited" -ge "$WAIT_TIMEOUT_SECONDS" ]; then
      echo "Timeout waiting for docs update lock ($LOCK_DIR) after ${waited}s." >&2
      exit 2
    fi

    sleep 1
  done
}

LOCK_DIR="${DOCS_DIR}.lock"
wait_for_update_lock

if command -v rg >/dev/null 2>&1; then
  RG_ARGS=(--hidden --glob '!.git/*' -n)
  if [ "${IGNORE_CASE}" = "1" ]; then
    RG_ARGS+=("-i")
  fi
  if [ "${CONTEXT}" != "0" ]; then
    RG_ARGS+=("-C" "${CONTEXT}")
  fi
  if [ -n "$TOP" ]; then
    rg "${RG_ARGS[@]}" "$QUERY" "$DOCS_DIR" | head -n "$TOP"
  else
    rg "${RG_ARGS[@]}" "$QUERY" "$DOCS_DIR"
  fi
else
  GREP_ARGS=(-RIn --exclude-dir=.git)
  if [ "${IGNORE_CASE}" = "1" ]; then
    GREP_ARGS+=(-i)
  fi
  if [ "${CONTEXT}" != "0" ]; then
    GREP_ARGS+=(-C "$CONTEXT")
  fi
  if [ -n "$TOP" ]; then
    grep "${GREP_ARGS[@]}" -- "$QUERY" "$DOCS_DIR" | head -n "$TOP"
  else
    grep "${GREP_ARGS[@]}" -- "$QUERY" "$DOCS_DIR"
  fi
fi
