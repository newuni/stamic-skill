# Response Guidelines (Statamic 6)

Purpose: keep responses consistent, actionable, and traceable to official Statamic documentation.

## Domain routing taxonomy

Use this as a first-pass classifier before searching docs.

- **Blueprints / Fieldsets**: fields, validation expectations, content modeling.
- **Content (Entries/Terms/Globals)**: CRUD patterns, publishing, localization.
- **Structures**: navigation trees, form/global structures, asset containers.
- **Templates**: Antlers/Blade usage, tags/modifiers, escaping/security.
- **System / Caching**: Stache, static caching, cache clear/warm behavior.
- **Users / Roles / Permissions**: RBAC and editorial workflows.
- **Assets**: containers/disks, metadata, permissions.
- **Sites**: multi-site configuration and localization.
- **Addons / Extensibility**: tags/modifiers/fieldtypes/widgets/utilities.

## Response checklist

1. Confirm version assumptions (default: Statamic 6).
2. Cite sources (`statamic.dev` and/or `statamic/docs` path).
3. Provide at least one actionable next step (command, path, snippet).
4. Mention pitfalls only when relevant (cache, multi-site, escaping/security).

## Statamic vs Laravel boundary

- Statamic-specific: model/content/template/stache behavior -> answer in this skill.
- Laravel-specific: framework internals (DB/Eloquent/queues/debugging) -> use official Laravel docs and project standards.
- Mixed tasks: separate Statamic and Laravel steps explicitly.
