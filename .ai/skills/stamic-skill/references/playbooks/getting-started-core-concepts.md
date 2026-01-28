# Getting Started: Core Concepts

**Summary:** Statamic is opinionated (conventions matter) but configurable; it’s “flat-first” by default; you define your own content schema (collections/fields/taxonomies); you bring the HTML and decide how to assemble templates (Antlers or Blade). The Control Panel is helpful but not mandatory for everything.

**When to use:**
- Choosing conventions (Antlers vs Blade, project structure, what to keep in git).
- Deciding flat files vs database/repositories.
- Explaining “how Statamic thinks” to new team members.

## Steps
1. Start with Statamic conventions and only deviate when you have a strong reason (e.g., integrating into an existing Laravel app).
2. Prefer **flat-first** storage until you have a real scaling/data-volume need; use repositories/db only when necessary.
3. Design your own content model:
   - pick field names
   - organize entries into collections
   - define taxonomies
   - choose URL patterns
4. Decide templating approach:
   - Prefer **Antlers** for deep Statamic integration and data handling directly in templates.
   - Use **Blade** if you want a more traditional Laravel MVC approach (controllers, etc.).
5. Keep a short project README documenting any deviations from defaults (paths, storage, templating choices, etc.).

## Pitfalls / gotchas
- Breaking conventions early can make future maintenance harder across projects/teams.
- Moving to databases/repositories adds complexity—avoid premature optimization.

## Sources
- https://statamic.dev/getting-started/core-concepts
