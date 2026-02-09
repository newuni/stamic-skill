#!/usr/bin/env bash
set -euo pipefail

# Quick smoke test for the Statamic docs mirror + search tooling.
#
# Usage:
#   ./scripts/smoke_statamic_docs.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$SCRIPT_DIR/update_statamic_docs.sh" >/dev/null

# Note: search script expects the mirror at the skill default path.
# (update_statamic_docs.sh uses the same default).

# Pick a couple of terms that should exist across versions.
TERMS=("collections" "blueprint" "webauthn")

for term in "${TERMS[@]}"; do
  echo "[smoke] searching: $term"
  first_line=$("$SCRIPT_DIR/search_statamic_docs.sh" --ignore-case --context 1 "$term" 2>/dev/null | head -n 1 || true)
  if [ -z "$first_line" ]; then
    echo "[smoke] FAILED: no results for '$term'" >&2
    exit 1
  fi
  echo "[smoke] ok: $term"
done

echo "[smoke] OK"