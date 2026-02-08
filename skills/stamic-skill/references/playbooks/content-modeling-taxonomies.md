# Content Modeling: Taxonomies

**Summary:** Taxonomies (e.g., tags, categories) group entries by shared attributes via “terms”. Terms can have their own fields (blueprints) and routes. When a taxonomy is attached to a collection, Statamic wires up fields/variables/routes in a strict, predictable way.

**When to use:**
- You need tagging/categorization and term pages.
- You want to filter/list entries by a shared attribute.

## Steps
1. Create a taxonomy (usually via the Control Panel).
2. Attach the taxonomy to one or more collections (collection-level setting) so terms relate to entries in a controlled way.
3. (Optional) Create one or more taxonomy blueprints to add fields to terms.
4. Create views for taxonomy/term pages (routing is auto-created **if the corresponding view exists**):
   - Global taxonomy index: `{taxonomy_handle}/index` → e.g. `resources/views/tags/index.antlers.html`
   - Global term show: `{taxonomy_handle}/show` → e.g. `resources/views/tags/show.antlers.html`
   - Collection taxonomy index: `{collection}/{taxonomy_handle}/index` → e.g. `resources/views/products/tags/index.antlers.html`
   - Collection term show: `{collection}/{taxonomy_handle}/show` → e.g. `resources/views/products/tags/show.antlers.html`
5. Render terms on an entry:
   - Antlers: `{{ tags }} {{ title }} {{ /tags }}`
6. Render term listings on taxonomy routes:
   - use `{{ terms }}` (or the taxonomy name like `{{ tags }}`)
7. Render entries on a term route:
   - use `{{ entries }}` (paginate if needed)

## Pitfalls / gotchas
- URLs use slugs with dashes, views use handles with underscores.
- Terms are global across collections; if you need per-collection term data, consider separate taxonomies (e.g. `product_tags`).
- Taxonomy name conflicts with a tag name: disambiguate using `$` (e.g. `{{ $section }}` … `{{ /$section }}`).

## Sources
- https://statamic.dev/content-modeling/taxonomies
