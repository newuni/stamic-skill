# Advanced Topics: Static Caching

**Summary:** Static Caching stores rendered HTML for ultra-fast responses. Statamic supports two drivers:
- **application** (“half measure”): stores pages in Laravel cache (still hits PHP)
- **file** (“full measure”): writes `.html` files served directly by the web server (bypasses PHP)

**When to use:**
- You want big performance gains for mostly-static pages.

## Steps
1. Choose strategy in `config/statamic/static_caching.php`:
   ```php
   'strategy' => 'half', // application driver
   // or
   'strategy' => 'full', // file driver
   ```
2. Configure drivers:
   - application driver ("half measure"):
     ```php
     'half' => ['driver' => 'application'],
     ```
   - file driver ("full measure"):
     ```php
     'full' => [
       'driver' => 'file',
       'path' => public_path('static'),
       // optional:
       // 'permissions' => ['directory' => 0755, 'file' => 0644],
     ],
     ```
3. If using **full** (file) driver, add server rewrite rules (Apache/Nginx/IIS) so static files are served.
   - note: Herd/Valet handle rewrite rules locally.
4. Keep dynamic fragments dynamic:
   - wrap dynamic parts with the `nocache` tag.
   - note: `nocache` in full-measure relies on JavaScript.
5. Warm cache before traffic:
   ```bash
   php please static:warm
   ```
   Useful flags:
   - `--queue` warm in background
   - `--include='/about,/blog/*'` / `--exclude='/contact'`
   - `--uncached` fill gaps only
   - `--max-depth=1` / `--max-requests=200`
   - `--header='Authorization: Bearer …'` for protected routes
6. Configure exclusions:
   - `exclude.urls` supports wildcards (`/blog/*`, `/news*`).
   - for dynamic logic, implement a custom `UrlExcluder`.
7. Configure invalidation:
   - default invalidates the saved item's URL.
   - define invalidation rules per collection/taxonomy/global/nav.
   - if you really need it, set rules to `all`.
8. Optional: background recache (avoid the next user paying the cold-cache cost):
   - set `background_recache` to true.
   - configure the recache token and server rules; get token via:
     ```bash
     php please static:recache-token
     ```
9. If caching varies by query strings:
   - by default, different query strings cache separately.
   - you can enable `ignore_query_strings` if you want a single cache per URL.

## Pitfalls / gotchas
- Static caching can break features like **forms with server-side validation**, **page protection**, and **randomized content**.
- Whatever is on the page the *first time* it is cached is what everyone will get. Be extremely careful with any per-user content.
- For full-measure caching, remember your **web server** is now responsible for serving cached HTML; misconfigured rewrite rules = cache bypass or 404s.

## Sources
- https://statamic.dev/advanced-topics/static-caching
