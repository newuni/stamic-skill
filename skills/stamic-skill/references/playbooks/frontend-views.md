# Frontend: Views (Layouts, Templates, Partials)

**Summary:** Frontend views live in `resources/views`. Statamic combines a **template** into a **layout** at `{{ template_content }}`. Partials are reusable views included with the `partial` tag.

**When to use:**
- Structuring Antlers/Blade views cleanly.

## Steps
1. Layout:
   - default: `resources/views/layout.antlers.html`
   - insert template output with `{{ template_content }}`.
   - change default in `config/statamic/system.php` (`layout`).
2. Template:
   - entry can set `template: gallery` (maps to `gallery.antlers.html`).
   - set collection template to `@blueprint` to map by blueprint:
     `resources/views/{collection}/{blueprint}.antlers.html`.
3. Partials:
   - include with `{{ partial:blog/card }}` (maps to `_card.antlers.html`).
   - convention: prefix partial files with `_`.
4. Blade views:
   - name files `*.blade.php`.
   - data is available, but Statamic tags aren’t.
5. Organizing conventions:
   - flat (small sites), by type (partials/layouts/templates), or by section.

## Pitfalls / gotchas
- Layout/template injection rule differs when the template is Blade: Blade template ignores Statamic layout and you should use Blade’s `@extends`.

## Sources
- https://statamic.dev/frontend/views
