# Content Modeling: Collections

**Summary:** Collections are containers of entries. A collection defines URL patterns (routes), available fields (blueprints), date behaviors (scheduling/visibility), defaults/injected data, ordering/structure, and other behaviors shared across its entries.

**When to use:**
- Creating a new content type (blog posts, products, pages, events).
- Debugging routing, scheduling, ordering, visibility, or default values.

## Steps
1. Create a collection in the Control Panel (recommended) or define it in `content/collections/<handle>.yaml`.
2. Understand storage:
   - collection config: `content/collections/<handle>.yaml`
   - entries: `content/collections/<handle>/*.md`
3. Set defaults/injected values in the collection YAML using `inject:`.
4. Configure blueprints:
   - default blueprint is created with the same name
   - create additional blueprints when you have distinct entry “shapes”
   - hide a blueprint via `hide: true` if needed
5. Decide on slugs:
   - default is slug from title
   - disable slug requirement via `slugs: false` (file names use ID instead of slug)
6. Configure dates and visibility:
   - enable dates if needed
   - set `date_behavior` for past/future: `public`, `unlisted`, or `private`
   - prefer filtering by computed status (published/scheduled/expired/draft) rather than the raw boolean
7. If needed, make it orderable (structured) and set `max_depth`.
8. Configure routing:
   - define `route:` (Statamic doesn’t auto-create it)
   - optionally set per-site routes in multi-site
   - add an index route by mounting the collection to an entry (common) or creating a custom route
9. Use “mounting” when you want entries to be subpages of a section entry.

## Pitfalls / gotchas
- Forgetting `route:` means entries may not have URLs.
- For scheduled content + caching, you may need to set up the scheduler so caches invalidate at the right time.
- In structured collections, “order” can override default sorting unless you explicitly sort in queries.

## Sources
- https://statamic.dev/content-modeling/collections
