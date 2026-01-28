# Control Panel: Utilities

**Summary:** Utilities are standalone CP tools (views/routes/nav items) bundled with a permission. Statamic ships utilities (cache manager, phpinfo, search index tools, email test), and you can register your own via the `Utility` facade (typically for addons).

**When to use:**
- Creating an internal admin tool in the CP.
- Shipping a CP tool with an addon.

## Steps
1. Register a utility inside `Utility::extend(...)`:
   - `Utility::register('<handle>')->inertia('<inertia-component>', fn($request) => [...])`
2. Register the Inertia page component in your CP JS:
   - `Statamic.$inertia.register('addon::Component', Component)`
3. Customize listing/nav details with chained methods:
   - `title`, `navTitle`, `icon`, `description`, `docsUrl`
4. Add routes for actions:
   - `->routes(fn($router) => $router->post('/', ...)->name('process'))`
   - generate URLs with `cp_route('utilities.<handle>')`
5. Permissions:
   - a permission is registered automatically, e.g. `access <handle> utility`
6. Use Blade utilities if needed via `->view(...)` (with limitations).

## Pitfalls / gotchas
- Blade-rendered utilities trigger full reloads and don’t support tags inside the view.
- Use `fill="currentColor"` for custom SVG icons.

## Sources
- https://statamic.dev/control-panel/utilities
