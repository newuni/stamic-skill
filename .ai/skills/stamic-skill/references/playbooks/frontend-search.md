# Frontend: Search

**Summary:** Statamic search is built from: a form input (`q`), the search results tag, one or more indexes (configured in `config/statamic/search.php`), and a driver (local/algolia/custom). Indexes store simplified searchable records for performance.

**When to use:**
- Adding site search.
- Improving relevance/performance with indexes.
- Implementing custom searchable types.

## Steps
1. Create a search form (plain HTML) with an input named `q` that submits to a results page.
2. Render results using the `search:results` tag and handle no-results.
3. Configure indexes in `config/statamic/search.php`:
   - pick driver (`local` or `algolia`)
   - pick `searchables` (content, collection:blog, taxonomy:tags, assets:container, users, addons, etc.)
   - choose `fields` to index
4. Optionally filter indexed items (`filter` closure or class) — remember: overriding filters can accidentally include drafts if you don’t filter them out.
5. Connect indexes to content types (e.g. set `search_index:` in collection YAML when using collection searchables).
6. Update indexes:
   - `php please search:update` (select)
   - `php please search:update <name>`
   - `php please search:update --all`
7. Multi-site: consider per-site indexes via `sites: [...]`.
8. Choose driver:
   - local (Comb): quick start
   - algolia: install client + set env vars + run `search:update`
9. Extend search with custom searchables/providers when indexing custom models.

## Pitfalls / gotchas
- Filters override native filters; be explicit about published/draft inclusion.
- Don’t over-index: keep records minimal (only fields needed for discovery).

## Sources
- https://statamic.dev/frontend/search
