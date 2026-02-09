#!/usr/bin/env bash
set -euo pipefail

# Full-text search a local clone of https://github.com/statamic/docs.
#
# Usage:
#   ./scripts/search_statamic_docs.sh [--docs-dir <path>] [--context <N>] [--] <query> [<extra tool args...>]
#
# Examples:
#   ./scripts/search_statamic_docs.sh "collections"
#   ./scripts/search_statamic_docs.sh --context 2 "webauthn"
#   ./scripts/search_statamic_docs.sh "blueprints" -- --glob '!**/README.md'
#   ./scripts/search_statamic_docs.sh --docs-dir /tmp/statamic-docs "antlers"

usage() {
  cat <<'EOF'
Search Statamic official docs (local mirror).

Usage:
  ./scripts/search_statamic_docs.sh [--docs-dir <path>] [--context <N>] [--ignore-case] [--] <query> [<extra tool args...>]

Options:
  --docs-dir <path>   Path to docs mirror (default: <skill-root>/.cache/statamic-docs)
  --context <N>       Show N lines of context around matches (default: 0)
  --ignore-case, -i   Case-insensitive search
  -h, --help          Show this help

Notes:
  - Prefers ripgrep (rg) if installed; falls back to grep.
  - This script assumes you already have a local docs mirror at --docs-dir (or the default path).
  - Keeping that mirror updated is intentionally out of scope for the published skill.
EOF
}

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
DOCS_DIR_DEFAULT="$ROOT_DIR/.cache/statamic-docs"
DOCS_DIR="$DOCS_DIR_DEFAULT"
CONTEXT=0
IGNORE_CASE=0

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
shift || true

if [ ! -d "$DOCS_DIR" ]; then
  echo "Docs not found at: $DOCS_DIR" >&2
  echo "This script requires a pre-existing local mirror of github.com/statamic/docs." >&2
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
  rg "${RG_ARGS[@]}" "$QUERY" "$DOCS_DIR" "$@"
else
  echo "[warn] ripgrep (rg) not found; falling back to grep. Install rg for faster/better search." >&2
  GREP_ARGS=(-RIn --exclude-dir=.git)
  if [ "${IGNORE_CASE}" = "1" ]; then
    GREP_ARGS+=(-i)
  fi
  if [ "${CONTEXT}" != "0" ]; then
    GREP_ARGS+=(-C "$CONTEXT")
  fi
  # Note: extra rg args after the query are ignored in grep mode.
  if [ $# -gt 0 ]; then
    echo "[warn] Extra tool args ignored in grep fallback mode: $*" >&2
  fi
  grep "${GREP_ARGS[@]}" -- "$QUERY" "$DOCS_DIR"
fi
