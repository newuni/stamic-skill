# Getting Started: Installing into an existing Laravel application

**Summary:** You can install Statamic into an existing Laravel app to manage marketing pages, add a blog, run headless, or manage existing data. This is more manual than a standard Statamic install: you must create collections/content and views/layouts yourself.

**When to use:**
- You already have a Laravel app and want Statamic for CMS features.
- You need Statamic as a headless CMS / REST API provider.

## Steps
1. Clear config cache before installing:
   ```bash
   php artisan config:clear
   ```
2. Add Statamic’s composer scripts in `composer.json` (pre-update and post-autoload-dump hooks).
3. Install Statamic:
   ```bash
   composer require statamic/cms --with-dependencies
   ```
4. If your auth/users setup requires it, publish Statamic auth migrations:
   ```bash
   php please auth:migration
   ```
5. Add content + views manually (none are included by default):
   - Create a Pages collection (route like `{parent_uri}/{slug}`, enable Orderable + root page).
   - Add `resources/views/layout.*` and `resources/views/default.*` (or your chosen equivalents).

## Pitfalls / gotchas
- Statamic uses a catch-all route; your explicitly defined Laravel routes take precedence. Avoid adding your own “catch-all” that blocks Statamic.
- You’ll get `content/`, `resources/users/`, `config/statamic/` directories after install.

## Sources
- https://statamic.dev/getting-started/installing/laravel
