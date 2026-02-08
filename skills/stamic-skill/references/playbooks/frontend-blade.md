# Frontend: Blade (templates)

**Summary:** Statamic can render views with Laravel Blade (`.blade.php`). You still get Statamic data injected, but Blade output escaping differs, and you won’t use Antlers tags directly unless you use Antlers Blade Components or the `@antlers` directive.

**When to use:**
- You’re integrating Statamic into an existing Laravel app with Blade.
- You prefer Laravel MVC routes/controllers.
- You want Blade components/partials reuse.

## Steps
1. Render a Blade template by naming it `myview.blade.php`.
2. Access current page data via `$page` (on normal Statamic-routed pages).
3. Remember escaping differences:
   - Antlers outputs unescaped
   - Blade `{{ }}` escapes; use `{!! !!}` for trusted HTML
4. Use globals via variables matching global set handles (e.g. `$settings->site_name`).
5. Use relationships:
   - property access resolves query builders to items
   - method access gives query builder for chaining (`$page->related_posts()->where(...)->get()`)
6. If cascade data isn’t present (e.g., blade components / non-Statamic controllers), use `@cascade` to inject it.
7. Use Antlers inside Blade if needed:
   - `@antlers ... @endantlers` (pure Antlers block)
   - Antlers Blade Components: `<s:collection ...>` / `<statamic:...>`
8. Use fluent tags/modifiers when convenient:
   - `Statamic::tag('collection:pages')->limit(3)`
   - `Statamic::modify($content)->stripTags()->ensureRight('!!!')`

## Pitfalls / gotchas
- On custom Laravel routes, `$page` may not exist.
- For conditional logic, values may be wrapped; use the `value()` helper if needed.
- Layout behavior differs: Blade templates don’t get injected into Antlers layouts automatically; use `@extends`/`@yield`, or combine Antlers template with Blade layout via `$template_content`.

## Sources
- https://statamic.dev/frontend/blade
