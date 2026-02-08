# Frontend: REST API (Content API)

**Summary:** Statamic’s Content REST API is a **read-only JSON API** for delivering content to frontends, SPAs, and external apps. It’s disabled by default and must be enabled per environment and per-resource.

**When to use:**
- Headless-ish usage (frontend consumes JSON).
- External integrations needing content.

## Steps
1. Enable the API:
   - `.env`:
     ```env
     STATAMIC_API_ENABLED=true
     ```
   - or `config/statamic/api.php`:
     ```php
     'enabled' => true,
     ```
2. Enable resources (security: all disabled by default):
   ```php
   'resources' => [
     'collections' => true,
     'taxonomies' => true,
     // ...
   ]
   ```
   For granular control:
   ```php
   'collections' => [
     'articles' => true,
     'pages' => true,
   ]
   ```
3. Use endpoints under:
   - `https://your-site.tld/api/{endpoint}`
   - Customize base route with `STATAMIC_API_ROUTE` or `api.php` `route`.
4. Filtering (opt-in):
   - configure `allowed_filters` per sub-resource.
   - query syntax:
     - `?filter[title:contains]=awesome&filter[featured]=true`
5. Sorting:
   - `?sort=field` or reverse `?sort=-field`
   - multiple: `?sort=one,-two`
6. Field selection:
   - `?fields=id,title,content`
7. Pagination:
   - `?limit=10&page=2` (default per-page 25)
8. Customize output by overriding API Resource classes:
   ```php
   Resource::map([EntryResource::class => CustomEntryResource::class]);
   ```
9. Caching:
   - responses are cached by default; tune expiry in `config/statamic/api.php`.
   - can ignore invalidation events or disable caching.
10. Authentication:
   - optional static token:
     ```env
     STATAMIC_API_AUTH_TOKEN=long-random-string
     ```
     send `Authorization: Bearer ...`
   - user-based auth: consider Laravel Sanctum.

## Pitfalls / gotchas
- Filters are disabled by default; expose only what you need.
- Multi-site: entries endpoint returns all sites unless filtered (`filter[site]=fr`).

## Sources
- https://statamic.dev/frontend/rest-api
- https://statamic.dev/content-api
