# Advanced Topics: Stache

**Summary:** The Stache is Statamic’s file-backed “database”: it aggregates YAML/content files into indexes stored in Laravel cache. It can be rebuilt at any time. It also has a file watcher for local dev.

**When to use:**
- Tuning performance for large sites.
- Understanding cache invalidation, indexing, and deployment steps.

## Steps
1. Configure the watcher (dev vs prod):
   - default recommended:
     ```env
     STATAMIC_STACHE_WATCHER=auto
     ```
   - for production, disable to avoid per-request overhead (if you’re not editing files directly):
     ```env
     STATAMIC_STACHE_WATCHER=false
     ```
2. Manage stache with CLI:
   ```bash
   php please stache:clear
   php please stache:warm
   php please stache:refresh
   ```
   - best practice: run `stache:refresh` after deployments.
3. Know stores:
   - entries, collections, taxonomies/terms, navs, globals, asset containers, users, etc.
   - configure in `config/statamic/stache.php`:
     - store `directory`
     - optionally store `class`
4. Preconfigure indexes you know you’ll query often:
   - add per-store `indexes: ['awesome', ...]` or global `indexes: [...]`.
   - warm them via `php please stache:warm`.
5. Choose cache store:
   - by default uses Laravel default cache store.
   - set `CACHE_STORE=redis` (or similar), or set `statamic.stache.cache_store`.
6. Locks:
   - if enabled, concurrent requests may wait while indexes are being built/updated; configure timeout.

## Pitfalls / gotchas
- Watcher is great locally but costly on production.
- Assets store directory isn’t configured here (it’s configured via the asset container).

## Sources
- https://statamic.dev/advanced-topics/stache
