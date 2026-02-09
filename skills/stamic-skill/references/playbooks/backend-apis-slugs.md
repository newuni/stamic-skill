# Backend & APIs: Slugs

**Summary:** The Slugs page is currently a placeholder in Statamic 6 docs. In practice, slug behavior should be handled through content-modeling conventions (collection routing, entry fields, validation) and project-specific rules.

**When to use:**
- You need predictable URL/slug behavior for entries and routes.
- You found legacy slug API references and need a supported 6.x implementation path.

## Steps
1. Define slug expectations in your content model (blueprints, routing patterns, validation).
2. Keep slug generation rules deterministic (normalization, uniqueness strategy, locale behavior).
3. Validate route resolution after slug changes across site locales and collections.
4. For deep customization, verify against current source before implementing internal hooks.

## Pitfalls / gotchas
- Slug rules that ignore locale/site context can create collisions in multi-site setups.
- Import/migration scripts often bypass editorial validation and generate inconsistent slugs.

## Sources
- https://statamic.dev/backend-apis/slugs
