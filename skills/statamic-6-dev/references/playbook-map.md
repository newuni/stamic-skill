# Statamic 6 docs → playbooks (work-in-progress)

Purpose: map canonical Statamic documentation to small, actionable playbooks.

Conventions:
- Status: `PENDING` | `DRAFTED` | `REFINED`
- Marker: `[LINK_ONLY]` = include as a reference link in the map, but **do not** convert to a playbook yet.
- Each playbook should aim for:
  1) one-paragraph summary
  2) 3–7 actionable steps
  3) pitfalls / gotchas
  4) citations (statamic.dev URL + optional statamic/docs path)

Process reference:
- See `references/playbook-process.md`

---

## Phase 1 (core): Getting Started (human/website order)

- [ ] **Requirements** — `DRAFTED`
  - Docs: https://statamic.dev/getting-started/requirements

- [ ] **Core Concepts** — `DRAFTED`
  - Docs: https://statamic.dev/getting-started/core-concepts

- [ ] **Quick Start Guide** — `DRAFTED`
  - Docs: https://statamic.dev/getting-started/quick-start-guide

- [ ] **Installing Statamic (overview)** — `DRAFTED`
  - Docs: https://statamic.dev/getting-started/installing

  Sub-pages (core dev):
  - [ ] **Installing locally** — `DRAFTED`
    - Docs: https://statamic.dev/getting-started/installing/local
  - [ ] **Installing with Laravel** — `DRAFTED`
    - Docs: https://statamic.dev/getting-started/installing/laravel
  - [ ] **Installing with Laravel Herd** — `DRAFTED`
    - Docs: https://statamic.dev/getting-started/installing/laravel-herd

  Sub-pages (hosts/platforms) — `[LINK_ONLY]`:
  - https://statamic.dev/getting-started/installing/ubuntu
  - https://statamic.dev/getting-started/installing/docker
  - https://statamic.dev/getting-started/installing/digital-ocean
  - https://statamic.dev/getting-started/installing/linode
  - https://statamic.dev/getting-started/installing/laravel-forge-1-click

- [ ] **Configuration** — `DRAFTED`
  - Docs: https://statamic.dev/getting-started/configuration

Getting Started (links only for now):
- [LINK_ONLY] Licensing — https://statamic.dev/getting-started/licensing
- [LINK_ONLY] Upgrade guide — https://statamic.dev/getting-started/upgrade-guide
- [LINK_ONLY] Updating — https://statamic.dev/getting-started/updating
- [LINK_ONLY] Deploying — https://statamic.dev/getting-started/deploying

---

## Phase 2 (core): Content Modeling (human/website order)

- [ ] **Overview** — `DRAFTED`
  - Docs: https://statamic.dev/content-modeling/overview

- [ ] **Collections** — `DRAFTED`
  - Docs: https://statamic.dev/content-modeling/collections

- [ ] **Taxonomies** — `DRAFTED`
  - Docs: https://statamic.dev/content-modeling/taxonomies

- [ ] **Globals** — `DRAFTED`
  - Docs: https://statamic.dev/content-modeling/globals

- [ ] **Navigation** — `DRAFTED`
  - Docs: https://statamic.dev/content-modeling/navigation

- [ ] **Routing** — `DRAFTED`
  - Docs: https://statamic.dev/content-modeling/routing

- [ ] **Blueprints** — `DRAFTED`
  - Docs: https://statamic.dev/content-modeling/blueprints

- [ ] **Fieldsets** — `DRAFTED`
  - Docs: https://statamic.dev/content-modeling/fieldsets

- [ ] **Fields** — `DRAFTED`
  - Docs: https://statamic.dev/content-modeling/fields

- [ ] **Structures** — `DRAFTED`
  - Docs: https://statamic.dev/content-modeling/structures

- [ ] **Computed Values** — `DRAFTED`
  - Docs: https://statamic.dev/content-modeling/computed-values

- [ ] **Data Inheritance** — `DRAFTED`
  - Docs: https://statamic.dev/content-modeling/data-inheritance

- [ ] **Relationships** — `DRAFTED`
  - Docs: https://statamic.dev/content-modeling/relationships

- [ ] **Revisions** — `DRAFTED`
  - Docs: https://statamic.dev/content-modeling/revisions

- [ ] **Validation** — `DRAFTED`
  - Docs: https://statamic.dev/content-modeling/validation

---

## Phase 3 (core): Control Panel (human/website order)

- [ ] **Overview** — `DRAFTED`
  - Docs: https://statamic.dev/control-panel/overview

- [ ] **Users** — `DRAFTED`
  - Docs: https://statamic.dev/control-panel/users

- [ ] **Dashboard** — `DRAFTED`
  - Docs: https://statamic.dev/control-panel/dashboard

- [ ] **Command Palette** — `DRAFTED`
  - Docs: https://statamic.dev/control-panel/command-palette

- [ ] **Preferences** — `DRAFTED`
  - Docs: https://statamic.dev/control-panel/preferences

Next (pending):
- [ ] Permissions — `DRAFTED` — https://statamic.dev/control-panel/permissions
- [ ] Multi-Site — `DRAFTED` — https://statamic.dev/control-panel/multi-site

Links only for now:
- [LINK_ONLY] Git Automation — https://statamic.dev/control-panel/git-automation
- [LINK_ONLY] Live Preview — https://statamic.dev/control-panel/live-preview
- [LINK_ONLY] Conditional Fields — https://statamic.dev/control-panel/conditional-fields
- [LINK_ONLY] Translations — https://statamic.dev/control-panel/cp-translations
- [LINK_ONLY] White Labeling — https://statamic.dev/control-panel/white-labeling
- [LINK_ONLY] Elevated Sessions — https://statamic.dev/control-panel/elevated-sessions
- [LINK_ONLY] Utilities — https://statamic.dev/control-panel/utilities

---

## Later phases (not core-first, kept for reference)

### Ops / Deployment

- [ ] **Timezones (UTC, display timezone, modifiers)** — `PENDING`
  - Docs: https://statamic.dev/knowledge-base/tips/timezones
  - Related: https://statamic.dev/knowledge-base/tips/change-timezone-to-utc

- [ ] **Zero downtime deployments (multi-release, cache isolation, git automation)** — `PENDING`
  - Docs: https://statamic.dev/knowledge-base/tips/zero-downtime-deployments

### Performance

- [ ] **Optimizing assets (stache watcher, remote disks)** — `PENDING`
  - Docs: https://statamic.dev/knowledge-base/tips/optimizing-assets

- [ ] **Caching overview** — `PENDING`
  - Docs: https://statamic.dev/advanced-topics/caching

- [ ] **Stache** — `PENDING`
  - Docs: https://statamic.dev/advanced-topics/stache

- [ ] **Static caching** — `PENDING`
  - Docs: https://statamic.dev/advanced-topics/static-caching

### Frontend / Templating

- [ ] **Antlers** — `PENDING`
  - Docs: https://statamic.dev/frontend/antlers

- [ ] **Blade** — `PENDING`
  - Docs: https://statamic.dev/frontend/blade

- [ ] **Content queries** — `PENDING`
  - Docs: https://statamic.dev/frontend/content-queries

### Addons / Extensibility

- [ ] **Addons overview + building** — `PENDING`
  - Docs: https://statamic.dev/addons/overview
  - Docs: https://statamic.dev/addons/building-an-addon
