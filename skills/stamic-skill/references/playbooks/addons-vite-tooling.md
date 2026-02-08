# Addons: Vite Tooling

**Summary:** Recommended asset pipeline for Statamic addons is Vite. Add a `package.json`, `vite.config.js` using `laravel-vite-plugin` + `@statamic/cms/vite-plugin`, JS/CSS entrypoints, and configure the addon's `AddonServiceProvider` with a `$vite` property mirroring the Vite inputs/output.

**When to use:**
- Your addon ships CP JS/Vue components, Inertia pages, or CSS.
- You’re building fieldtypes/widgets/utilities that need JS.

## Required files / structure (typical)
```
your-addon/
  resources/
    dist/
    js/addon.js
    css/addon.css
  src/ServiceProvider.php
  vite.config.js
  package.json
```

## Steps
1. Create `package.json` with scripts and dependencies:
   - `laravel-vite-plugin` for common configuration + HMR
   - `@statamic/cms` pulled from your vendor directory
2. Create `vite.config.js`:
   - inputs: `resources/js/addon.js` + `resources/css/addon.css`
   - set `publicDirectory: 'resources/dist'` (or your chosen output)
   - add `statamic()` plugin
3. Implement `resources/js/addon.js`:
   - wrap registrations in `Statamic.booting(() => { ... })`
   - register components with `Statamic.$components.register(...)`
   - register Inertia pages with `Statamic.$inertia.register(...)`
4. Implement `resources/css/addon.css`.
5. Add `$vite` property to your addon's ServiceProvider (extends `AddonServiceProvider`) matching vite config:
   - `input: [...]`
   - `publicDirectory: 'resources/dist'`
6. Development:
   ```bash
   npm install
   npm run dev
   ```
   If you see “Vite manifest not found” in CP, the dev server/build hasn’t been run yet.
7. Optional: enable CP dev build (HMR/devtools) when `APP_DEBUG=true`:
   ```bash
   php artisan vendor:publish --tag=statamic-cp-dev
   # or symlink dist-dev into public/vendor/statamic/cp-dev
   ```
8. If using Herd/Valet with TLS, set `detectTls` in Vite config.
9. Build for deployment:
   ```bash
   npm run build
   ```
10. Ensure the app can serve compiled assets:
   - either `vendor:publish` your addon's tag, or
   - symlink addon's `resources/dist` into `public/vendor/...`

## Pitfalls / gotchas
- Don’t commit the CP dev build (`public/vendor/statamic/cp-dev`) or use it in production.
- Output directory must exist (e.g. `resources/dist`).

## Sources
- https://statamic.dev/addons/vite-tooling
