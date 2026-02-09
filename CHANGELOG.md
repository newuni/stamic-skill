# Changelog

## 1.0.1 — 2026-02-09

- Updated docs to reflect the script split: mirror maintenance lives in `dev-scripts/` and runtime search stays in `skills/stamic-skill/scripts/`.
- Added `dev-scripts/check_repo_consistency.sh` to catch broken script references and version drift.
- Added root README maintenance commands and explicit smoke-test expectation.

## 1.0.0 — 2026-01-29

- First stable release of the **stamic-skill** (Statamic 6 Dev) skill.
- Documentation-driven workflow (statamic.dev as canonical source + statamic/docs mirror for fast search).
- Playbooks + coverage map included.
- Scripts included for updating and searching the local docs mirror.
