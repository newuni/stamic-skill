# Frontend: Views (layouts, templates, partials)

**Summary:** Views live in `resources/views/`. Layouts wrap templates via `{{ template_content }}` (Antlers). Templates render per-page content. Partials are reusable snippets included via the `partial` tag. Blade views (`.blade.php`) are rendered by Laravel’s Blade engine.

**When to use:**
- Organizing templates and deciding conventions.
- Understanding how layout/template/partial composition works.

## Steps
1. Create views in `resources/views/`.
2. Layouts:
   - default is `resources/views/layout.antlers.html`
   - set injection point with `{{ template_content }}`
   - entries can override layout via `layout: <name>`
   - default layout can be configured in `config/statamic/system.php` (`layout`)
3. Templates:
   - entries can set `template: <name>`
   - use `template: '@blueprint'` on a collection to map to `resources/views/{collection}/{blueprint}.antlers.html`
4. Partials:
   - include with `{{ partial:blog/card }}`
   - convention: prefix partial filenames with `_` and omit it in the partial tag.
5. Blade views:
   - `.blade.php` uses Blade; same data is injected
   - but you don’t have Statamic tags in Blade (use Antlers Blade Components / `@antlers` when needed)
6. Choose an organization style (flat / by type / by section) and stick to it.

## Pitfalls / gotchas
- If you use Blade templates, remember layout injection rules differ from Antlers.

## Sources
- https://statamic.dev/frontend/views
