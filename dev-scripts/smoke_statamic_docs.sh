#!/usr/bin/env bash
set -euo pipefail

# Quick smoke test for the Statamic docs mirror + search tooling.
#
# Usage:
#   ./dev-scripts/smoke_statamic_docs.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/stamic-skill-smoke.XXXXXX")"
DOCS_DIR="$TMP_ROOT/statamic-docs"

cleanup() {
  if [ -n "${TMP_ROOT:-}" ] && [ -d "$TMP_ROOT" ]; then
    rm -rf "$TMP_ROOT" || true
  fi
}

trap cleanup EXIT INT TERM

echo "[smoke] bootstrapping and searching in parallel"
"$SCRIPT_DIR/search_statamic_docs.sh" --docs-dir "$DOCS_DIR" --top 1 "antlers" >"$TMP_ROOT/out.1" 2>"$TMP_ROOT/err.1" &
pid1=$!
"$SCRIPT_DIR/search_statamic_docs.sh" --docs-dir "$DOCS_DIR" --top 1 "assets" >"$TMP_ROOT/out.2" 2>"$TMP_ROOT/err.2" &
pid2=$!
"$SCRIPT_DIR/search_statamic_docs.sh" --docs-dir "$DOCS_DIR" --top 1 "blueprint" >"$TMP_ROOT/out.3" 2>"$TMP_ROOT/err.3" &
pid3=$!

wait "$pid1"
wait "$pid2"
wait "$pid3"

for output_file in "$TMP_ROOT/out.1" "$TMP_ROOT/out.2" "$TMP_ROOT/out.3"; do
  if [ ! -s "$output_file" ]; then
    echo "[smoke] FAILED: concurrent search produced empty output ($output_file)" >&2
    exit 1
  fi
done

echo "[smoke] running deterministic checks"
"$SCRIPT_DIR/update_statamic_docs.sh" --docs-dir "$DOCS_DIR" >/dev/null

# Pick a couple of terms that should exist across versions.
TERMS=("collections" "blueprint" "webauthn")

for term in "${TERMS[@]}"; do
  echo "[smoke] searching: $term"
  first_line=$("$SCRIPT_DIR/search_statamic_docs.sh" --docs-dir "$DOCS_DIR" --ignore-case --context 1 "$term" 2>/dev/null | head -n 1 || true)
  if [ -z "$first_line" ]; then
    echo "[smoke] FAILED: no results for '$term'" >&2
    exit 1
  fi
  echo "[smoke] ok: $term"
done

echo "[smoke] OK"
