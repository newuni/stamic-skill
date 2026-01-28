# Advanced Topics: Static Caching

**Summary:** Static Caching stores rendered HTML for ultra-fast responses. Statamic supports two drivers:
- **application** (“half measure”): stores pages in Laravel cache (still hits PHP)
- **file** (“full measure”): writes `.html` files served directly by the web server (bypasses PHP)

**When to use:**
- You want big performance gains for mostly-static pages.

## Steps
1. Choose strategy in `config/statamic/static_caching.php`:
   ```php
   'strategy' => 'half', // or 'full'
   ```
2. Configure drivers:
   - application driver:
     ```php
     'half' => ['driver' => 'application'],
     ```
   - file driver:
     ```php
     'full' => ['driver' => 'file', 'path' => public_path('static')],
     ```
3. If using **full** (file) driver, add server rewrite rules (Apache/Nginx/IIS) so static files are served.
4. Keep dynamic fragments dynamic:
   - use the `nocache` tag for dynamic parts.
   - note: `nocache` in full-measure relies on JavaScript.
5. Warm cache before traffic:
   ```bash
   php please static:warm
   ```
   - useful flags: `--queue`, `--include`, `--exclude`, `--uncached`, `--max-depth`, `--header`.
6. Configure exclusions:
   - static_caching `exclude.urls` (supports wildcards)
   - or implement a custom UrlExcluder class.
7. Configure invalidation:
   - default invalidates the saved item’s URL
   - add invalidation rules per collection/taxonomy/global/nav
   - or set rules to `all`.
8. Optional: background recache:
   - enable `background_recache` and set up `static:recache-token` + rewrite rules.

## Pitfalls / gotchas
- Static caching can break features like forms with validation, protection, randomization.
- Whatever is cached first can leak protected content if you’re not careful.

## Sources
- https://statamic.dev/advanced-topics/static-caching
