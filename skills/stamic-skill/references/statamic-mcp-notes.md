# Notes inspired by cboxdk/statamic-mcp (lightweight)

Goal: reuse the *useful* structuring ideas without importing MCP complexity.

## Domain taxonomy (for routing questions)

Use this as a first-pass classifier to decide what to search and what to answer.

- **Blueprints / Fieldsets**: fields, validation expectations, content modeling.
- **Content (Entries/Terms/Globals)**: CRUD patterns, publishing, localization.
- **Structures**: navigations, collections structures, forms, globals structure, asset containers.
- **Templates**: Antlers vs Blade usage, tags/modifiers, performance, security.
- **System / Caching**: stache, static caching, views; when to clear/warm; config.
- **Users / Roles / Permissions**: RBAC, multi-user dev workflows.
- **Assets**: containers/disks, metadata, permissions.
- **Sites**: multi-site configuration, site switching, localized content.
- **Addons / Extensibility**: custom tags/modifiers/fieldtypes, addon structure.

## Response checklist (small but high-signal)

When answering, include only what matters:

1) **Confirm version**: assume Statamic 6 unless user says otherwise.
2) **Cite the source**: link to statamic.dev and/or the exact statamic/docs file/section.
3) **Give an actionable next step**: command, file path, or minimal snippet.
4) **Mention common pitfalls only if relevant**:
   - cache/stache implications
   - multi-site implications
   - security (escaping/XSS) for template work

## Statamic vs Laravel Boost (decision rule)

- If the task is about **Statamic concepts** (blueprints, entries, Antlers, tags/modifiers, Stache), keep it in this skill.
- If the task is about **Laravel mechanics** (DB queries, Eloquent, queues, debugging, Artisan internals), route to Laravel Boost guidance.
- For mixed tasks, answer Statamic parts here and explicitly mark which steps belong to Boost.
