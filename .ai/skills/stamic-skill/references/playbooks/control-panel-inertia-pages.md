# Control Panel: Inertia Pages (Custom CP pages)

**Summary:** Statamic CP is powered by Inertia.js. Custom CP pages should be implemented as Vue page components registered with `Statamic.$inertia.register`, and returned from controllers via `Inertia::render(...)` for SPA-like navigation.

**When to use:**
- You’re building custom CP screens (in apps or addons).
- You want CP UX consistent with Statamic (instant navigation, shared UI).

## Steps
1. Register your page component in `cp.js` (app) or addon's `addon.js`:
   ```js
   import Foo from './pages/Foo.vue';

   Statamic.booting(() => {
     Statamic.$inertia.register('app::Foo', Foo);
   });
   ```
2. Return it from a controller:
   ```php
   use Inertia\Inertia;

   return Inertia::render('app::Foo', [
     'message' => 'Hello world!',
   ]);
   ```
3. In Vue, use Inertia primitives from `@statamic/cms/inertia`:
   - `<Head>` for titles
   - `<Link>` for navigation (avoid `<a>` reload)
4. Dev workflow (apps): `php please setup-cp-vite`, then `npm run cp:dev` / `npm run cp:build`.
   - For addons prefer the dedicated Vite tooling guide.
5. Optional: add external or inline scripts:
   - `Statamic::externalScript(url)`
   - `Statamic::inlineScript('...')` (without `<script>` tags)

## Pitfalls / gotchas
- Use `<Link>` to preserve SPA behavior.
- Don’t commit the CP dev build (`public/vendor/statamic/cp-dev`).

## Sources
- https://statamic.dev/control-panel/css-javascript
