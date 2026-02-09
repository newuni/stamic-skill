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
- [ ] Conditional Fields — `DRAFTED` — https://statamic.dev/control-panel/conditional-fields
- [ ] Translations — `DRAFTED` — https://statamic.dev/control-panel/cp-translations
- [ ] White Labeling — `DRAFTED` — https://statamic.dev/control-panel/white-labeling
- [ ] Keyboard Shortcuts — `DRAFTED` — https://statamic.dev/control-panel/keyboard-shortcuts
- [ ] Elevated Sessions — `DRAFTED` — https://statamic.dev/control-panel/elevated-sessions
- [ ] Customizing the CP Nav — `DRAFTED` — https://statamic.dev/control-panel/customizing-the-cp-nav
- [ ] Multi-User Collaboration — `DRAFTED` — https://statamic.dev/control-panel/multi-user-collaboration
- [ ] Publish Forms — `DRAFTED` — https://statamic.dev/control-panel/publish-forms

Also drafted:
- [ ] Git Automation — `DRAFTED` — https://statamic.dev/control-panel/git-automation
- [ ] Live Preview — `DRAFTED` — https://statamic.dev/control-panel/live-preview
- [ ] Toast Notifications — `DRAFTED` — https://statamic.dev/control-panel/toast-notifications
- [ ] Utilities — `DRAFTED` — https://statamic.dev/control-panel/utilities
- [ ] Routing (CP) — `REFINED` — https://statamic.dev/control-panel/routing
- [ ] Field Actions — `REFINED` — https://statamic.dev/control-panel/field-actions

Extending:
- [ ] CP Navigation — `REFINED` — https://statamic.dev/extending/cp-navigation
- [LINK_ONLY] CP Navigation (legacy/alt URL) — https://statamic.dev/control-panel/cp-navigation

---

## Phase 4 (core): Frontend (human/website order)

- [ ] Frontend Overview — `DRAFTED` — https://statamic.dev/frontend/overview
- [ ] Antlers Templates — `REFINED` — https://statamic.dev/frontend/antlers
- [ ] Blade Templates — `REFINED` — https://statamic.dev/frontend/blade
- [ ] Views — `REFINED` — https://statamic.dev/frontend/views

Next (pending):
- [ ] Augmentation — `REFINED` — https://statamic.dev/frontend/augmentation
- [ ] Assets (frontend) — `REFINED` — https://statamic.dev/frontend/assets
- [ ] Forms (frontend) — `REFINED` — https://statamic.dev/frontend/forms
- [ ] Content queries — `REFINED` — https://statamic.dev/frontend/content-queries
- [ ] Search (frontend) — `DRAFTED` — https://statamic.dev/frontend/search
- [ ] Image manipulation (Glide) — `DRAFTED` — https://statamic.dev/frontend/image-manipulation
- [ ] Controllers — `DRAFTED` — https://statamic.dev/frontend/controllers
- [ ] View Models — `DRAFTED` — https://statamic.dev/frontend/view-models
- [ ] Protecting Content — `DRAFTED` — https://statamic.dev/frontend/protecting-content
- [ ] REST API — `DRAFTED` — https://statamic.dev/frontend/rest-api
- [ ] GraphQL API — `DRAFTED` — https://statamic.dev/graphql
- [LINK_ONLY] GraphQL API (alt URL) — https://statamic.dev/frontend/graphql
- [ ] Front-End Frameworks — `REFINED` — https://statamic.dev/frontend/javascript-frameworks
- [ ] Customizing Markdown — `REFINED` — https://statamic.dev/frontend/markdown
- [ ] Blade Form Field Templates — `REFINED` — https://statamic.dev/frontend/blade-form-fields
- [ ] Frontend Advanced Topics — `PENDING (page missing/removed in 6.x; /frontend/advanced-topics returns 404)` — https://statamic.dev/frontend/advanced-topics

---

## Later phases (not core-first, kept for reference)

### Starter Kits

- [LINK_ONLY] Starter kits overview — https://statamic.dev/starter-kits/overview
- [LINK_ONLY] Installing a starter kit — https://statamic.dev/starter-kits/installing-a-starter-kit
- [LINK_ONLY] Creating a starter kit — https://statamic.dev/starter-kits/creating-a-starter-kit
- [LINK_ONLY] Updating a starter kit — https://statamic.dev/starter-kits/updating-a-starter-kit

### Knowledge Base (indexes)

- [LINK_ONLY] Content Managers Guide — https://statamic.dev/knowledge-base/content-managers-guide
- [LINK_ONLY] Tips index — https://statamic.dev/knowledge-base/tips
- [LINK_ONLY] Troubleshooting index — https://statamic.dev/knowledge-base/troubleshooting

### Ops / Deployment

- [ ] **Timezones (UTC, display timezone, modifiers)** — `DRAFTED`
  - Docs: https://statamic.dev/knowledge-base/tips/timezones
  - Related: https://statamic.dev/knowledge-base/tips/change-timezone-to-utc

- [ ] **Zero downtime deployments (multi-release, cache isolation, git automation)** — `DRAFTED`
  - Docs: https://statamic.dev/knowledge-base/tips/zero-downtime-deployments

### Performance

- [ ] **Optimizing assets (stache watcher, remote disks)** — `DRAFTED`
  - Docs: https://statamic.dev/knowledge-base/tips/optimizing-assets

- [ ] **Caching overview** — `DRAFTED`
  - Docs: https://statamic.dev/advanced-topics/caching

- [ ] **Stache** — `DRAFTED`
  - Docs: https://statamic.dev/advanced-topics/stache

- [ ] **Static caching** — `REFINED`
  - Docs: https://statamic.dev/advanced-topics/static-caching

Advanced Topics (more):
- [ ] CLI — `DRAFTED` — https://statamic.dev/cli
- [LINK_ONLY] CLI (alt URL) — https://statamic.dev/advanced-topics/cli
- [ ] YAML — `DRAFTED` — https://statamic.dev/advanced-topics/yaml
- [ ] Lifecycle — `DRAFTED` — https://statamic.dev/advanced-topics/lifecycle
- [ ] Debugging — `DRAFTED` — https://statamic.dev/advanced-topics/debugging
- [ ] Sending email — `DRAFTED` — https://statamic.dev/advanced-topics/email
- [LINK_ONLY] Sending email (old URL?) — https://statamic.dev/advanced-topics/sending-email
- [ ] Task scheduling — `DRAFTED` — https://statamic.dev/advanced-topics/scheduling
- [ ] OAuth — `DRAFTED` — https://statamic.dev/advanced-topics/oauth
- [ ] Sites API — `DRAFTED` — https://statamic.dev/advanced-topics/sites-api

### Frontend / Templating

- [ ] **Antlers** — `REFINED`
  - Docs: https://statamic.dev/frontend/antlers

- [ ] **Blade** — `REFINED`
  - Docs: https://statamic.dev/frontend/blade

- [ ] **Content queries** — `REFINED`
  - Docs: https://statamic.dev/frontend/content-queries

- [ ] **Meta: Tags / Modifiers / Fieldtypes / Variables** — `REFINED`
  - Playbook: `references/playbooks/frontend-tags-modifiers-fieldtypes-variables-meta.md`
  - Roots:
    - Tags: https://statamic.dev/tags/overview | https://statamic.dev/tags/all-tags
    - Modifiers: https://statamic.dev/modifiers/overview | https://statamic.dev/modifiers/all-modifiers
    - Fieldtypes: https://statamic.dev/fieldtypes/overview | https://statamic.dev/fieldtypes/all-fieldtypes
    - Variables: https://statamic.dev/variables/all-variables

## Phase 5: Addons / Extending (initial slice)

- [ ] Addons overview — `DRAFTED` — https://statamic.dev/addons/overview
- [ ] Building an addon — `REFINED` — https://statamic.dev/addons/building-an-addon
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
- [LINK_ONLY] Data (alt URL) — https://statamic.dev/backend-apis/data
- [LINK_ONLY] Query scopes & filters (alt URL) — https://statamic.dev/backend-apis/query-scopes-and-filters
- [ ] Query scopes & filters — `DRAFTED (page empty in 6.x)` — https://statamic.dev/backend-apis/query-scopes-filters
- [ ] Repositories — `DRAFTED` — https://statamic.dev/backend-apis/repositories
- [ ] Data retrieval and manipulation — `DRAFTED (page empty in 6.x)` — https://statamic.dev/backend-apis/data-retrieval-and-manipulation
- [ ] Resource APIs — `DRAFTED (page stub in 6.x)` — https://statamic.dev/backend-apis/resource-apis

Resource APIs (concrete repositories) — `[LINK_ONLY]`:
- https://statamic.dev/backend-apis/resource-apis/asset-container-repository
- https://statamic.dev/backend-apis/resource-apis/asset-repository
- https://statamic.dev/backend-apis/resource-apis/collection-repository
- https://statamic.dev/backend-apis/resource-apis/entry-repository
- https://statamic.dev/backend-apis/resource-apis/form-repository
- https://statamic.dev/backend-apis/resource-apis/form-submission-repository
- https://statamic.dev/backend-apis/resource-apis/global-repository
- https://statamic.dev/backend-apis/resource-apis/site-repository
- https://statamic.dev/backend-apis/resource-apis/taxonomy-repository
- https://statamic.dev/backend-apis/resource-apis/term-repository
- https://statamic.dev/backend-apis/resource-apis/user-group-repository
- https://statamic.dev/backend-apis/resource-apis/user-repository
- https://statamic.dev/backend-apis/resource-apis/user-role-repository

- [ ] Vue components (deeper) — `REFINED` — (recipes + append patterns)
