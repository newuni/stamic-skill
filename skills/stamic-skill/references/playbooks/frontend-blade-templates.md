# Frontend: Blade Templates

**Summary:** Statamic can render frontend views using Laravel Blade (`*.blade.php`). You still get Statamic data (e.g. `$page`, globals), and you can use Antlers in Blade via `@antlers` or Antlers Blade Components (`<s:collection ...>`). Tags aren’t available directly unless using those mechanisms.

**When to use:**
- You prefer Blade, share views with Laravel apps, or need Blade tooling.

## Steps
1. Use `myview.blade.php` extension.
2. Access current page:
   - `$page->title`, `$page->content`, etc.
3. Remember Blade escapes by default:
   - use `{!! !!}` for HTML.
4. Use `@cascade` to pull cascade data into scope when needed.
5. Write pure Antlers blocks inside Blade:
   ```blade
   @antlers
     {{ collection:articles }}{{ title }}{{ /collection:articles }}
   @endantlers
   ```
6. Use Antlers Blade Components:
   ```blade
   <s:collection from="pages" limit="2">{{ $title }}</s:collection>
   ```
   - dynamic params via `:from="$collection"`.
7. Fluent tags and modifiers:
   - `Statamic::tag('collection:pages')->limit(3)`
   - `Statamic::modify($content)->stripTags()->ensureRight('!')`
8. Layout behavior:
   - Blade templates ignore Statamic layout/template injection; use Blade’s `@extends`.
   - You can still use an Antlers template with a Blade layout (use `$template_content`).

## Pitfalls / gotchas
- Conditional checks on `Value` objects may need `value()`; use `Statamic\View\Blade\value()` helper.

## Sources
- https://statamic.dev/frontend/blade
