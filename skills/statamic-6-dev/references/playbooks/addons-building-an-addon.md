# Addons: Building an Addon

**Summary:** An addon is a Composer package for reusable/distributable Statamic functionality. You can scaffold one with `php please make:addon`, develop it locally as a path repository, and wire components (tags/modifiers/fieldtypes/widgets/commands), routes (cp/actions/web), assets (Vite), utilities, settings, and update scripts in an `AddonServiceProvider`.

**When to use:**
- You need reusable Statamic features across projects.
- You want to ship CP extensions (routes, utilities, settings UI).
- You’re building a marketplace package.

## Steps
1. Scaffold:
   ```bash
   php please make:addon vendor/my-addon
   ```
2. Ensure the addon has:
   - `composer.json` with `extra.statamic` + `extra.laravel.providers`
   - a service provider extending `Statamic\Providers\AddonServiceProvider`
   - use `bootAddon()` (not `boot()`) for addon boot logic
3. Install locally using a Composer path repository in the project root `composer.json`, then `composer update`.
4. Register components (automatic if conventions match; otherwise via provider properties):
   - `$tags`, `$modifiers`, `$fieldtypes`, `$widgets`, `$commands`
5. Assets:
   - prefer Vite tooling
   - publish assets via `$vite`, `$scripts`, `$stylesheets`, `$publishables`
   - control auto-publish with `$publishAfterInstall`
6. Routes:
   - keep route files in `src/routes/{cp,actions,web}.php` (auto-registered)
   - understand prefixes:
     - CP routes: `/cp/...` + auth
     - action routes: `/!/addon-name/...`
     - web routes: normal Laravel web routes
7. CP pages:
   - use Inertia (register Vue pages with `Statamic.$inertia.register`)
8. Settings:
   - register a settings blueprint so users can edit addon settings in CP
   - store settings in `resources/addons` by default
9. Updates:
   - ship UpdateScript classes for migrations/permission changes
10. Editions:
   - define editions in `composer.json` and toggle features by edition

## Pitfalls / gotchas
- Route model binding: using params like `{entry}` may auto-resolve to Statamic objects.
- If you need config caching, avoid closures in config; use classes.

## Sources
- https://statamic.dev/addons/building-an-addon
