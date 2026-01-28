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
- [ ] Conditional Fields — `DRAFTED` — https://statamic.dev/control-panel/conditional-fields
- [ ] Translations — `DRAFTED` — https://statamic.dev/control-panel/cp-translations
- [ ] White Labeling — `DRAFTED` — https://statamic.dev/control-panel/white-labeling
- [ ] Keyboard Shortcuts — `DRAFTED` — https://statamic.dev/control-panel/keyboard-shortcuts
- [ ] Elevated Sessions — `DRAFTED` — https://statamic.dev/control-panel/elevated-sessions
- [ ] Utilities — `DRAFTED` — https://statamic.dev/control-panel/utilities
- [ ] Customizing the CP Nav — `DRAFTED` — https://statamic.dev/control-panel/customizing-the-cp-nav

---

## Phase 4 (core): Frontend (human/website order)

- [ ] Frontend Overview — `DRAFTED` — https://statamic.dev/frontend/overview
- [ ] Antlers Templates — `DRAFTED` — https://statamic.dev/frontend/antlers
- [ ] Blade Templates — `DRAFTED` — https://statamic.dev/frontend/blade
- [ ] Views — `DRAFTED` — https://statamic.dev/frontend/views

Next (pending):
- [ ] Augmentation — `DRAFTED` — https://statamic.dev/frontend/augmentation
- [ ] Assets (frontend) — `DRAFTED` — https://statamic.dev/frontend/assets
- [ ] Forms (frontend) — `DRAFTED` — https://statamic.dev/frontend/forms
- [ ] Content queries — `DRAFTED` — https://statamic.dev/frontend/content-queries
- [ ] Search (frontend) — `DRAFTED` — https://statamic.dev/frontend/search
- [ ] Image manipulation (Glide) — `DRAFTED` — https://statamic.dev/frontend/image-manipulation
- [ ] Controllers — `DRAFTED` — https://statamic.dev/frontend/controllers

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

## Phase 5: Addons / Extending (initial slice)

- [ ] Addons overview — `DRAFTED` — https://statamic.dev/addons/overview
- [ ] Building an addon — `DRAFTED` — https://statamic.dev/addons/building-an-addon
- [ ] Tags overview — `DRAFTED` — https://statamic.dev/tags/overview
- [ ] Modifiers overview — `DRAFTED` — https://statamic.dev/modifiers/overview
- [ ] Build a fieldtype — `DRAFTED` — https://statamic.dev/fieldtypes/build-a-fieldtype

Next (pending):
- [ ] Vite tooling (addons) — `DRAFTED` — https://statamic.dev/addons/vite-tooling
- [ ] Building a tag — `DRAFTED` — https://statamic.dev/tags/building-a-tag
- [ ] Extending modifiers — `DRAFTED` — https://statamic.dev/extending/modifiers
- [ ] Widgets — `DRAFTED` — https://statamic.dev/widgets/all-widgets

Next-next (pending):
- [ ] Widgets: building a widget — `DRAFTED` — https://statamic.dev/widgets/building-a-widget
- [ ] Utilities (CP) — `DRAFTED` — https://statamic.dev/control-panel/utilities
- [ ] Commands (addons) — `DRAFTED` — (see building addon docs)
- [ ] Control Panel (Inertia pages) — `DRAFTED` — https://statamic.dev/control-panel/css-javascript
- [ ] Testing (addons) — `DRAFTED` — https://statamic.dev/addons/testing

Next-next-next (pending):
- [ ] Actions — `DRAFTED` — https://statamic.dev/backend-apis/actions
- [ ] Hooks — `DRAFTED` — https://statamic.dev/backend-apis/hooks
- [ ] Events — `DRAFTED` — https://statamic.dev/backend-apis/events
- [ ] Vue components — `DRAFTED` — https://statamic.dev/vue-components/overview
- [ ] UI components — `DRAFTED` — https://ui.statamic.dev

Next (pending):
- [ ] Blink cache — `DRAFTED` — https://statamic.dev/backend-apis/blink-cache
- [ ] Event bus — `DRAFTED (page empty in 6.x)` — https://statamic.dev/backend-apis/event-bus
- [ ] Dirty state tracking — `DRAFTED (page empty in 6.x)` — https://statamic.dev/backend-apis/dirty-state-tracking
- [ ] Slugs — `DRAFTED (page empty in 6.x)` — https://statamic.dev/backend-apis/slugs
- [ ] Progress — `DRAFTED (page empty in 6.x)` — https://statamic.dev/backend-apis/progress

Next after that (pending):
- [ ] Query scopes & filters — `DRAFTED (page empty in 6.x)` — https://statamic.dev/backend-apis/query-scopes-filters
- [ ] Repositories — `DRAFTED` — https://statamic.dev/backend-apis/repositories
- [ ] Data retrieval and manipulation — `DRAFTED (page empty in 6.x)` — https://statamic.dev/backend-apis/data-retrieval-and-manipulation
- [ ] Resource APIs — `DRAFTED (page stub in 6.x)` — https://statamic.dev/backend-apis/resource-apis
- [ ] Vue components (deeper) — `DRAFTED` — (recipes + append patterns)
