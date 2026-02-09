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
  ./scripts/search_statamic_docs.sh [--docs-dir <path>] [--ignore-case] [--context <N>] [--top <N>] <query>

Options:
  --docs-dir <path>   Docs mirror path (default: <skill-root>/.cache/statamic-docs)
  --ignore-case, -i   Case-insensitive search
  --context <N>       Show N lines of context (default: 0)
  --top <N>           Limit to N result lines (default: unlimited)
  -h, --help          Show this help

Output:
  A grep/rg-style stream of lines: path:line:match

Notes:
  - Prefers ripgrep (rg) if installed; falls back to grep.
  - Requires an existing local mirror of github.com/statamic/docs.
EOF
}

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
DOCS_DIR_DEFAULT="$ROOT_DIR/.cache/statamic-docs"
DOCS_DIR="$DOCS_DIR_DEFAULT"
CONTEXT=0
IGNORE_CASE=0
TOP=""

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
  echo "Docs not found at: $DOCS_DIR" >&2
  echo "This script requires a local mirror of github.com/statamic/docs." >&2
  exit 2
fi

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
