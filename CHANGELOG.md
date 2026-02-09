# Changelog

## 1.0.3 — 2026-02-09

- Removed duplicate playbooks and kept a single canonical file per topic.
- Normalized all playbooks to the required template sections (`Summary`, `Steps`, `Sources`).
- Reworked playbook index generation to use canonical map matches (`Docs:` and explicit `Playbook:` references) instead of ambiguous URL intersections.
- Hardened sync checks with duplicate-title and required-section validation.
- Removed non-canonical ecosystem references and legacy Boost/Clawdbot wording from skill docs.

## 1.0.2 — 2026-02-09

- Added `dev-scripts/generate_playbook_index.sh` to build `skills/stamic-skill/references/playbook-index.md`.
- Added `dev-scripts/check_playbook_sync.sh` to validate playbook-map URL coverage and index freshness.
- Added Playbook Sync CI job in `.github/workflows/repo-maintenance.yml`.
- Updated docs and playbook sources to use canonical URL mappings for sync checks.

## 1.0.1 — 2026-02-09

- Updated docs to reflect the script split: mirror maintenance lives in `dev-scripts/` and runtime search stays in `skills/stamic-skill/scripts/`.
- Added `dev-scripts/check_repo_consistency.sh` to catch broken script references and version drift.
- Added root README maintenance commands and explicit smoke-test expectation.

## 1.0.0 — 2026-01-29

- First stable release of the **stamic-skill** (Statamic 6 Dev) skill.
- Documentation-driven workflow (statamic.dev as canonical source + statamic/docs mirror for fast search).
- Playbooks + coverage map included.
- Scripts included for updating and searching the local docs mirror.
