# Advanced Topics: CLI

**Summary:** Statamic’s CLI is built on Laravel Artisan. `php please` is a polite alias for `php artisan statamic:`. Use it to install Statamic, scaffold extensions (tags/fieldtypes/modifiers/widgets/actions), and manage caches (stache/static/glide/assets).

**When to use:**
- Scaffolding add-ons/extensions.
- Clearing/warming caches.
- Support diagnostics.

## Steps
1. List Statamic commands:
   ```bash
   php please list
   ```
2. List all Artisan commands (Laravel + Statamic + packages):
   ```bash
   php artisan list
   ```
3. Remember: `please` == `artisan statamic:`
   ```bash
   php please make:user
   # is the same as
   php artisan statamic:make:user
   ```
4. Get help for a specific command:
   ```bash
   php please help make:user
   ```
5. Common “core ops” commands:
   - Stache: `stache:clear|warm|refresh|doctor`
   - Static caching: `static:clear|warm`
   - Glide cache: `glide:clear`
   - Search: `search:update`
   - Support: `support:details`

## Pitfalls / gotchas
- `php artisan cache:clear` clears the Laravel cache (which also contains the Stache).

## Sources
- https://statamic.dev/advanced-topics/cli
