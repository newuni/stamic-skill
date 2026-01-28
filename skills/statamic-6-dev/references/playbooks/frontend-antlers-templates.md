# Frontend: Antlers Templates

**Summary:** Antlers is Statamic’s template language/engine. It uses `{{ }}` expressions to render variables, run tags, apply modifiers, and control flow. Antlers is tightly integrated with Statamic (tags, augmentation, auth, etc.).

**When to use:**
- Standard Statamic templating.

## Steps
1. Use `.antlers.html` extension so views are parsed.
2. Know delimiters:
   - `{{ }}` render/logic/tags
   - `{{# #}}` comments
   - `{{? ?}}` / `{{$ $}}` PHP execution/echo
3. Configure guarding in `config/statamic/antlers.php`:
   - guarded variables/tags/modifiers.
4. Variables:
   - `{{ title }}`
   - optional disambiguation: `{{ $title }}`
5. Loops:
   - arrays: `{{ items }} {{ value }} {{ /items }}`
6. Conditions:
   - `{{ if logged_in }} ... {{ /if }}`
   - null coalescing: `{{ meta_title ?? title ?? site:name }}`
7. Modifiers:
   - `{{ title | upper | ensure_right('!') }}`
8. Assignments:
   - `{{ total = 0 }}` then `{{ total += 1 }}`

## Pitfalls / gotchas
- Antlers outputs unescaped by default; use `sanitize` for user-submitted data.

## Sources
- https://statamic.dev/frontend/antlers
