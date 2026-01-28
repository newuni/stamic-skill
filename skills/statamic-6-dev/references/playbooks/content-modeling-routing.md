# Content Modeling: Routing

**Summary:** Statamic handles site requests unless you define explicit Laravel routes. URLs come from content routes (collections/terms), Statamic routes (Route::statamic), redirects, and standard Laravel routes. You can disable Statamic routes for headless/API usage.

**When to use:**
- You need a custom page that isn’t backed by an entry.
- You need wildcard routes, special layouts, JSON/XML endpoints, or redirects.
- You’re mixing Statamic with “normal” Laravel routing.

## Steps
1. Prefer content routes for entries/terms (configured on collections and taxonomies).
2. Use `Route::statamic()` when you want Statamic’s “magic” (globals, layout injection, middleware stack, view resolution):
   ```php
   Route::statamic('uri', 'view', ['foo' => 'bar']);
   ```
3. Use implicit view naming when URI == view:
   - `Route::statamic('my-page')`
   - `Route::statamic('/foo/bar') // implies 'foo.bar'`
4. Use wildcard params as needed:
   ```php
   Route::statamic('things/{thing}', 'things.show');
   ```
5. Customize layout on a statamic route via route data (`layout => 'custom'`).
6. For API-ish responses, use content-type shorthands (`json`, `xml`, `atom`) via route data.
7. For redirects, use Laravel redirects in `routes/web.php`.
8. If using Static Caching, add Statamic cache middleware to Laravel routes you want statically cached.
9. Error pages live in `resources/views/errors/{status_code}.antlers.html` (and optional `errors/layout.antlers.html`).
10. Headless mode: disable Statamic routes via `config/statamic/routes.php` (`'enabled' => false`).

## Pitfalls / gotchas
- Explicit Laravel routes take precedence; don’t accidentally shadow Statamic routes with your own catch-alls.
- 5xx error pages render template only (no layout injection).

## Sources
- https://statamic.dev/content-modeling/routing
