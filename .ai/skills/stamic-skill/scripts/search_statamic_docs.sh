#!/usr/bin/env bash
set -euo pipefail

# Full-text search Statamic docs clone.
# Usage:
#   ./scripts/search_statamic_docs.sh "query" [-- <extra rg args>]
# Examples:
#   ./scripts/search_statamic_docs.sh "collections" 
#   ./scripts/search_statamic_docs.sh "blueprints" -- -n --glob '!**/README.md'

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
DOCS_DIR="$ROOT_DIR/.cache/statamic-docs"
QUERY="${1:-}"

if [ -z "$QUERY" ]; then
  echo "Missing query."
  exit 2
fi

if [ ! -d "$DOCS_DIR" ]; then
  echo "Docs not found at $DOCS_DIR"
  echo "Run: ./scripts/update_statamic_docs.sh"
  exit 2
fi

shift || true

if command -v rg >/dev/null 2>&1; then
  rg --hidden --glob '!.git/*' "$QUERY" "$DOCS_DIR" "$@"
else
  echo "[warn] ripgrep (rg) not found; falling back to grep -R. Install rg for faster/better search."
  # Basic fallback (no extra rg args support).
  grep -RIn --exclude-dir=.git -- "$QUERY" "$DOCS_DIR"
fi
