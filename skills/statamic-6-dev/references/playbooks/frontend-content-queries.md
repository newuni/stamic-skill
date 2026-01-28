# Frontend: Content Queries (PHP query builder)

**Summary:** Statamic provides a fluent query builder for content types (Entries, Users, Assets, Globals, etc.) via facades + repositories. It’s similar in feel to Laravel’s query builder/Eloquent, but it’s a separate implementation and works across storage drivers (flat files, Eloquent, custom repos).

**When to use:**
- You’re building controllers / custom routes and need to fetch content in PHP.
- You want advanced filtering/sorting/pagination beyond what tags provide.

## Steps
1. Use facades to access repositories (e.g. `Entry::find(...)`, `GlobalSet::findByHandle(...)`).
2. Use query builders when available:
   ```php
   use Statamic\Facades\Entry;

   $entries = Entry::query()
     ->where('collection', 'blog')
     ->limit(5)
     ->get();
   ```
3. Fetch a single record with `first()`.
4. For DB drivers, optimize by selecting specific fields:
   - `->get(['title', 'hero_image', 'content'])`
5. Use common clauses:
   - `where`, `orWhere`, array-of-wheres
   - `whereIn`, `whereNull`, `whereBetween`, `whereDate/Month/Day/Year/Time`, `whereColumn`
6. Use closure-based complex wheres and conditional clauses:
   - `->where(fn($q) => ...)`
   - `->when($cond, fn($q) => ..., fn($q) => ...)` / `->unless(...)`
7. Query JSON fields with `->` selectors and helpers:
   - `whereJsonContains`, `whereJsonOverlaps`, `whereJsonLength`, etc.
8. Sort and page:
   - `orderBy`, `orderByDesc`, `inRandomOrder`
   - `offset`, `limit`
   - `paginate(perPage)` (returns Laravel paginator)
9. For large datasets:
   - `chunk(count, callback)`
   - `lazy(chunkSize)`

## Pitfalls / gotchas
- Statamic’s query builder is not Laravel’s query builder; supported methods/operators differ.

## Sources
- https://statamic.dev/frontend/content-queries
