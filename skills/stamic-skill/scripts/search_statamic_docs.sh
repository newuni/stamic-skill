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
  ./scripts/search_statamic_docs.sh [--docs-dir <path>] [--ignore-case] [--context <N>] [--top <N>] [--rank-mode <mode>] [--no-bootstrap] [--wait-timeout <N>] <query>

Options:
  --docs-dir <path>   Docs mirror path (default: <skill-root>/.cache/statamic-docs)
  --ignore-case, -i   Case-insensitive search
  --context <N>       Show N lines of context (default: 0)
  --top <N>           Limit to N result lines (default: unlimited)
  --rank-mode <mode>  Ranking mode: none|fzf|hybrid (default: none)
  --no-bootstrap      Do not auto-clone docs mirror when missing
  --wait-timeout <N>  Max seconds to wait for an update lock (default: 120)
  -h, --help          Show this help

Output:
  A grep/rg-style stream of lines: path:line:match

Notes:
  - Prefers ripgrep (rg) if installed; falls back to grep.
  - Optional fuzzy ranking via fzf is non-interactive and never required.
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
RANK_MODE="${STATAMIC_DOCS_RANK_MODE:-none}"
RANK_DISABLED_REASON=""
FZF_FALLBACK_REASON=""
LOCK_DIR=""
TMP_ROOT=""
RESULTS_FILE=""
RANKED_RESULTS_FILE=""

is_non_negative_integer() {
  [[ "$1" =~ ^[0-9]+$ ]]
}

cleanup_tmp() {
  if [ -n "$TMP_ROOT" ] && [ -d "$TMP_ROOT" ]; then
    rm -rf "$TMP_ROOT" || true
  fi
}

trap cleanup_tmp EXIT INT TERM

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
      if ! is_non_negative_integer "$CONTEXT"; then
        echo "Invalid --context '$CONTEXT'. Must be a non-negative integer." >&2
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
      if ! is_non_negative_integer "$TOP"; then
        echo "Invalid --top '$TOP'. Must be a non-negative integer." >&2
        exit 2
      fi
      shift 2
      ;;
    --rank-mode)
      RANK_MODE="${2:-}"
      if [ -z "$RANK_MODE" ]; then
        echo "Missing value for --rank-mode" >&2
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
      if ! is_non_negative_integer "$WAIT_TIMEOUT_SECONDS"; then
        echo "Invalid --wait-timeout '$WAIT_TIMEOUT_SECONDS'. Must be a non-negative integer." >&2
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

case "$RANK_MODE" in
  none|fzf|hybrid)
    ;;
  *)
    echo "Invalid --rank-mode '$RANK_MODE'. Allowed: none, fzf, hybrid." >&2
    exit 2
    ;;
esac

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

run_backend_search() {
  local rc=0

  if command -v rg >/dev/null 2>&1; then
    local rg_args
    rg_args=(--hidden --glob '!.git/*' -n)
    if [ "$IGNORE_CASE" = "1" ]; then
      rg_args+=("-i")
    fi
    if [ "$CONTEXT" != "0" ]; then
      rg_args+=("-C" "$CONTEXT")
    fi
    if ! rg "${rg_args[@]}" "$QUERY" "$DOCS_DIR" >"$RESULTS_FILE"; then
      rc=$?
      if [ "$rc" -ne 1 ]; then
        return "$rc"
      fi
    fi
  else
    local grep_args
    grep_args=(-RIn --exclude-dir=.git)
    if [ "$IGNORE_CASE" = "1" ]; then
      grep_args+=(-i)
    fi
    if [ "$CONTEXT" != "0" ]; then
      grep_args+=(-C "$CONTEXT")
    fi
    if ! grep "${grep_args[@]}" -- "$QUERY" "$DOCS_DIR" >"$RESULTS_FILE"; then
      rc=$?
      if [ "$rc" -ne 1 ]; then
        return "$rc"
      fi
    fi
  fi
}

should_rank_with_fzf() {
  if [ "$RANK_MODE" = "none" ]; then
    return 1
  fi

  if [ "$CONTEXT" != "0" ]; then
    RANK_DISABLED_REASON="context mode is enabled"
    return 1
  fi

  if ! command -v fzf >/dev/null 2>&1; then
    RANK_DISABLED_REASON="fzf not installed"
    return 1
  fi

  if [ "$RANK_MODE" = "hybrid" ]; then
    local line_count
    line_count="$(wc -l < "$RESULTS_FILE" | tr -d '[:space:]')"

    if [ -z "$TOP" ]; then
      RANK_DISABLED_REASON="hybrid mode requires --top"
      return 1
    fi

    if [ "${line_count:-0}" -le "$TOP" ]; then
      RANK_DISABLED_REASON="result count already <= --top"
      return 1
    fi
  fi

  return 0
}

apply_fzf_ranking() {
  local fzf_args rc=0
  fzf_args=(--delimiter ':' --nth=3.. --tiebreak=begin,index --filter "$QUERY")
  if [ "$IGNORE_CASE" = "1" ]; then
    fzf_args+=("-i")
  fi

  if ! fzf "${fzf_args[@]}" <"$RESULTS_FILE" >"$RANKED_RESULTS_FILE"; then
    rc=$?
    if [ "$rc" -ne 1 ]; then
      return "$rc"
    fi
  fi

  if [ ! -s "$RANKED_RESULTS_FILE" ]; then
    FZF_FALLBACK_REASON="fzf produced no ranked lines"
    return 1
  fi

  return 0
}

LOCK_DIR="${DOCS_DIR}.lock"
wait_for_update_lock

TMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/stamic-search.XXXXXX")"
RESULTS_FILE="$TMP_ROOT/results.txt"
RANKED_RESULTS_FILE="$TMP_ROOT/ranked-results.txt"

run_backend_search

if [ ! -s "$RESULTS_FILE" ]; then
  exit 0
fi

OUTPUT_FILE="$RESULTS_FILE"
if should_rank_with_fzf; then
  if apply_fzf_ranking; then
    OUTPUT_FILE="$RANKED_RESULTS_FILE"
  fi
elif [ "$RANK_MODE" != "none" ]; then
  echo "[statamic-docs] Ranking disabled (${RANK_DISABLED_REASON}); using plain results." >&2
fi

if [ "$OUTPUT_FILE" = "$RESULTS_FILE" ] && [ -n "$FZF_FALLBACK_REASON" ]; then
  echo "[statamic-docs] $FZF_FALLBACK_REASON; using plain results." >&2
fi

if [ -n "$TOP" ]; then
  head -n "$TOP" "$OUTPUT_FILE"
else
  cat "$OUTPUT_FILE"
fi
