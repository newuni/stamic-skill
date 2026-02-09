# Changelog

## 1.0.3 — 2026-02-09

- Removed duplicate playbooks and consolidated to one canonical file per topic.
- Brought all playbooks to a consistent template baseline (`Summary`, `Steps`, `Sources`).
- Reworked index generation/matching to prioritize explicit map references and canonical docs links.
- Strengthened playbook sync validation (duplicate titles + required section checks).
- Cleaned references to remove non-canonical ecosystem noise and legacy wording.

## 1.0.2 — 2026-02-09

- Added `dev-scripts/generate_playbook_index.sh` to generate a playbook coverage index from map + playbook URLs.
- Added `dev-scripts/check_playbook_sync.sh` to fail on map/playbook drift and stale generated index.
- Added CI playbook-sync job and updated map statuses/source links to remove current sync inconsistencies.

## 1.0.1 — 2026-02-09

- Updated script references after moving mirror-maintenance tooling to `dev-scripts/`.
- Kept `scripts/search_statamic_docs.sh` as the runtime lookup utility and updated examples.
- Added repository consistency checks to prevent stale paths and metadata/changelog version drift.

## 1.0.0 — 2026-01-29

- First stable release of the **stamic-skill** (Statamic 6 Dev) skill.
- Documentation-driven workflow (statamic.dev as canonical source + statamic/docs mirror for fast search).
- Playbooks + coverage map included.
- Scripts included for updating and searching the local docs mirror.
