# Frontend: Controllers

**Summary:** Because Statamic runs inside Laravel, you can use standard Laravel routes/controllers for custom frontend logic. Be aware: explicit Laravel routes take precedence over Statamic routes. To render Antlers with Statamic’s template+layout behavior, return a `Statamic\View\View`.

**When to use:**
- Building custom sections/apps beyond content routing.
- Headless-ish pages, special endpoints, bespoke business logic.
- You want MVC style with controllers.

## Steps
1. Define routes in `routes/web.php` and map to controllers.
2. Create controllers in `app/Http/Controllers` (e.g. `php artisan make:controller FooController`).
3. Render Blade views normally with `return view('myview', $data)`.
4. For Antlers templates with layout injection, return `new Statamic\View\View`:
   ```php
   return (new \Statamic\View\View)
     ->template('myview')
     ->layout('mylayout')
     ->with(['title' => 'Example Title']);
   ```
5. To include entry content in the cascade, use `cascadeContent($entry)`.

## Pitfalls / gotchas
- Your Laravel routes can shadow Statamic URLs if you define overlapping/catch-all routes.

## Sources
- https://statamic.dev/frontend/controllers
