# Frontend: Content Queries (PHP)

**Summary:** Statamic provides fluent query builders for core data types (Entry, Term, Asset, User, etc.) backed by repositories. Works across storage drivers (Stache, Eloquent, custom).

**When to use:**
- Controllers/routes, ViewModels, custom PHP integrations.

## Steps
1. Use facades to retrieve single items:
   ```php
   Entry::find('abc123');
   GlobalSet::findByHandle('footer')->inDefaultSite()->get('copyright');
   ```
2. Use query builders for filtering:
   ```php
   $entries = Entry::query()->where('collection', 'blog')->limit(5)->get();
   ```
3. Get one record:
   - `first()`
4. Select specific fields (useful on DB drivers):
   - `get(['title', 'content'])`
5. Common clauses:
   - `where`, `orWhere`, `whereIn`, `whereBetween`, `whereNull`, etc.
6. JSON fields:
   - `where('field->sub', '!=', 'x')`
   - `whereJsonContains`, `whereJsonLength`, overlaps/doesnt...
7. Ordering:
   - `orderBy`, `orderByDesc`, `inRandomOrder`
8. Pagination:
   - `paginate(15)`
9. Chunk/stream:
   - `chunk(25, fn ($items) => ...)`
   - `lazy(100)`

## Pitfalls / gotchas
- Statamic’s query builder resembles Laravel’s but is a separate implementation.

## Sources
- https://statamic.dev/frontend/content-queries
- https://statamic.dev/extending/repositories
