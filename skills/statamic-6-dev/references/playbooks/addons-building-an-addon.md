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
2. Core structure:
   - `composer.json` with:
     - `extra.statamic` (so Statamic recognizes it as an addon)
     - `extra.laravel.providers` (so Laravel auto-loads it)
   - a Service Provider extending `Statamic\Providers\AddonServiceProvider`
   - put boot logic in `bootAddon()` (not `boot()`) so it runs after Statamic boots
3. Local development install (path repository):
   - in project root `composer.json`:
     - add to `require`: `"vendor/my-addon": "*"`
     - add to `repositories`: `{ "type": "path", "url": "addons/vendor/my-addon" }`
   - then run:
     ```bash
     composer update
     ```
4. Register components:
   - many autoload by convention, but you can explicitly list them in your provider:
     - `$tags`, `$modifiers`, `$fieldtypes`, `$widgets`, `$commands`
5. Assets (Control Panel JS/CSS):
   - prefer Vite tooling.
   - publish assets via `$vite`, `$scripts`, `$stylesheets`, `$publishables`.
   - control auto-publish after install with `$publishAfterInstall`.
6. Routes:
   - convention-based files auto-registered: `src/routes/{cp,actions,web}.php`
   - prefixes/middleware:
     - CP routes: `/cp/...` and auth applied
     - action routes: `/!/addon-name/...` (good for frontend actions)
     - web routes: normal Laravel web routes (no Statamic middleware by default)
7. CP pages:
   - build CP pages with Inertia.
   - register pages in JS with `Statamic.$inertia.register('my-addon::Page', Component)`.
8. Settings UI:
   - register a settings blueprint so users can edit settings in CP.
   - settings stored in YAML under `resources/addons` by default.
9. Updates:
   - ship `UpdateScript` classes for migrations/changes when versions bump.
10. Editions:
   - define editions in `composer.json` and gate features by selected edition.

## Quick mental model
- **Composer** installs it.
- **AddonServiceProvider** wires it.
- **Vite** builds CP UI.
- **Routes** define CP/actions/web entrypoints.
- **Blueprint settings** make it configurable in CP.

## Pitfalls / gotchas
- Route model binding: using params like `{entry}` may auto-resolve to Statamic objects.
- If you need config caching, avoid closures in config; use classes.

## Sources
- https://statamic.dev/addons/building-an-addon
