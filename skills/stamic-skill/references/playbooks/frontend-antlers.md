# Frontend: Antlers (templates)

**Summary:** Antlers is Statamic’s native templating system (language + engine + tag library). Antlers templates are files in `resources/views` ending in `.antlers.html`. It’s designed to fetch/filter content and handle logic via tags/modifiers.

**When to use:**
- Default choice for Statamic-first builds.
- You want to leverage Statamic tags heavily (collections, taxonomies, assets, auth, etc.).

## Steps
1. Create Antlers views in `resources/views/*.antlers.html`.
2. Use `{{ ... }}` to render variables, call tags, and evaluate expressions.
3. Keep naming conventions consistent:
   - lowercase variables
   - underscores in variable names
   - readable whitespace inside braces
4. Know delimiters:
   - `{{ }}` main
   - `{{? ?}}` / `{{$ $}}` for PHP execution/echo
   - `{{# #}}` comments
5. Use modifiers with pipes:
   - `{{ title | upper | ensure_right('rocks!') }}`
6. Prefer null-coalescing for fallbacks:
   - `{{ meta_title ?? title ?? site:name }}`
7. Remember escaping:
   - Antlers output is unescaped by default; escape user-submitted data with `sanitize`.

## Pitfalls / gotchas
- File extension matters: without `.antlers.html`, the view renders as static HTML.
- Don’t output user-submitted content without escaping.

## Sources
- https://statamic.dev/frontend/antlers
