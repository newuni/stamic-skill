# Control Panel: Utilities (Extending)

**Summary:** Utilities are CP tools living under the Utilities area, with their own nav item, permission, and route(s). They’re a shortcut wrapper around: routes + view/Inertia page + permission + listing card metadata.

**When to use:**
- You want a CP tool (e.g., maintenance actions, migrations, dashboards, one-off operations).

## Steps
1. Register utilities inside a service provider `boot()`:
   - wrap in `Utility::extend(function () { ... })`
   - call `Utility::register('handle')` then chain methods.
2. Choose rendering strategy:
   - **Inertia** (recommended):
     ```php
     Utility::register('data_wangjangler')
       ->inertia('my-addon::DataWangjangler', fn ($request) => [
         'items' => Item::all(),
       ]);
     ```
   - register the page in your addon/app JS:
     ```js
     Statamic.booting(() => {
       Statamic.$inertia.register('my-addon::DataWangjangler', DataWangjangler);
     });
     ```
   - **Blade** (simple but SPA limitations):
     `->view('wangjangler', fn () => [...])`
3. Customize listing/nav card:
   - `title`, `navTitle`, `icon`, `description`, `docsUrl`.
4. Add routes beyond the default index route:
   ```php
   Utility::register('data_wangjangler')->routes(function ($router) {
     $router->post('/', [WangjanglerController::class, 'process'])->name('process');
   });
   ```
5. Use URL helpers:
   - `cp_route('utilities.data-wangjangler')`
   - `cp_route('utilities.data-wangjangler.process')`
6. Permissions are auto-registered:
   - `access <handle> utility`

## Pitfalls / gotchas
- Blade utilities cause full reloads and don’t support tags inside views.
- Avoid config closures if you expect config caching; use classes/controllers.

## Sources
- https://statamic.dev/control-panel/utilities
