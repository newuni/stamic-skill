# Statamic 6 docs → playbooks (work-in-progress)

Purpose: map canonical Statamic documentation pages to small, actionable playbooks. Start with everything **pending**, then progressively mark as drafted/reviewed.

Conventions:
- Status: `PENDING` | `DRAFTED` | `REFINED`
- Each playbook should aim for:
  1) one-paragraph summary
  2) 3–7 actionable steps
  3) pitfalls / gotchas
  4) citations (statamic.dev URL + optional statamic/docs path)

## Ops / Deployment

- [ ] **Timezones (UTC, display timezone, modifiers)** — `PENDING`
  - Docs: https://statamic.dev/knowledge-base/tips/timezones
  - Related: https://statamic.dev/knowledge-base/tips/change-timezone-to-utc
  - Notes: drafted in chat; convert to playbook.

- [ ] **Zero downtime deployments (multi-release, cache isolation, git automation)** — `PENDING`
  - Docs: https://statamic.dev/knowledge-base/tips/zero-downtime-deployments

- [ ] **Git workflow / Git automation** — `PENDING`
  - Docs: https://statamic.dev/knowledge-base/tips/git-workflow
  - Related: https://statamic.dev/git-automation

## Performance

- [ ] **Optimizing assets (stache watcher, remote disks)** — `PENDING`
  - Docs: https://statamic.dev/knowledge-base/tips/optimizing-assets

- [ ] **Static caching (configure, warm, invalidate)** — `PENDING`
  - Docs: https://statamic.dev/advanced-topics/static-caching

- [ ] **Caching overview** — `PENDING`
  - Docs: https://statamic.dev/advanced-topics/caching

- [ ] **Stache (what it stores, watcher, pitfalls)** — `PENDING`
  - Docs: https://statamic.dev/advanced-topics/stache

## Content modeling

- [ ] **Blueprints** — `PENDING`
  - Docs: https://statamic.dev/content-modeling/blueprints

- [ ] **Fields / fieldsets** — `PENDING`
  - Docs: https://statamic.dev/content-modeling/fields
  - Docs: https://statamic.dev/content-modeling/fieldsets

- [ ] **Collections (structure, routing)** — `PENDING`
  - Docs: https://statamic.dev/content-modeling/collections

- [ ] **Entries (CRUD, publish workflow)** — `PENDING`
  - Seed docs: https://statamic.dev/fieldtypes/entries
  - Related: https://statamic.dev/backend-apis/resource-apis/entry-repository

- [ ] **Taxonomies & terms** — `PENDING`
  - Docs: https://statamic.dev/content-modeling/taxonomies

- [ ] **Globals** — `PENDING`
  - Docs: https://statamic.dev/content-modeling/globals

- [ ] **Validation** — `PENDING`
  - Docs: https://statamic.dev/content-modeling/validation

- [ ] **Relationships** — `PENDING`
  - Docs: https://statamic.dev/content-modeling/relationships

## Multi-site

- [ ] **Multi-site setup** — `PENDING`
  - Docs: https://statamic.dev/control-panel/multi-site

- [ ] **Localizing entries** — `PENDING`
  - Docs: https://statamic.dev/knowledge-base/tips/localizing-entries

- [ ] **Localizing globals** — `PENDING`
  - Docs: https://statamic.dev/knowledge-base/tips/localizing-globals

- [ ] **Localizing navigation** — `PENDING`
  - Docs: https://statamic.dev/knowledge-base/tips/localizing-navigation

- [ ] **Converting single → multi-site** — `PENDING`
  - Docs: https://statamic.dev/knowledge-base/tips/converting-from-single-to-multi-site

## Frontend / Templating

- [ ] **Antlers overview + best practices** — `PENDING`
  - Docs: https://statamic.dev/frontend/antlers

- [ ] **Blade templating** — `PENDING`
  - Docs: https://statamic.dev/frontend/blade

- [ ] **Content queries (collections, filters, scopes)** — `PENDING`
  - Docs: https://statamic.dev/frontend/content-queries

- [ ] **Forms (frontend + submissions)** — `PENDING`
  - Docs: https://statamic.dev/frontend/forms

- [ ] **Assets in templates (glide, image manipulation)** — `PENDING`
  - Docs: https://statamic.dev/frontend/assets
  - Related: https://statamic.dev/frontend/image-manipulation

## Security

- [ ] **Content Security Policy (CSP) tip** — `PENDING`
  - Docs: https://statamic.dev/knowledge-base/tips/content-security-policy

- [ ] **GDPR considerations tip** — `PENDING`
  - Docs: https://statamic.dev/knowledge-base/tips/gdpr-considerations

## Team workflow

- [ ] **Multi-user collaboration (CP)** — `PENDING`
  - Docs: https://statamic.dev/control-panel/multi-user-collaboration

- [ ] **Default listing columns (CP)** — `PENDING`
  - Docs: https://statamic.dev/knowledge-base/tips/setting-default-listing-columns

## Addons / Extensibility

- [ ] **Addons overview + building** — `PENDING`
  - Docs: https://statamic.dev/addons/overview
  - Docs: https://statamic.dev/addons/building-an-addon

- [ ] **Tags & modifiers (custom + usage)** — `PENDING`
  - Docs: https://statamic.dev/tags/overview
  - Docs: https://statamic.dev/modifiers/overview
  - Related: https://statamic.dev/tags/building-a-tag

- [ ] **Fieldtypes (custom)** — `PENDING`
  - Docs: https://statamic.dev/fieldtypes/build-a-fieldtype

---

## Next slice to implement (suggested)

1) Timezones
2) Zero downtime deployments
3) Stache + caching (pair)
4) Blueprints + collections (pair)

As each playbook is drafted, create a corresponding reference file (one playbook per file) and flip status to `DRAFTED`.
