# Frontend: Blade Form Field Templates

**Summary:** Statamic’s *pre-rendered* form field HTML is shipped with Antlers templates, but you can publish and replace those snippets with Blade templates. This lets you keep your frontend rendering consistently in Blade while still using Statamic’s form field/validation metadata.

**When to use:**
- You render forms with Statamic’s `{{ form:create }}` tag / field loop and want Blade templates.
- You need to customize markup per fieldtype (classes, wrappers, inline layouts).

## Steps
1. Publish Statamic’s form field templates:
   ```bash
   php artisan vendor:publish --tag=statamic-forms
   ```
2. Edit the published templates in:
   ```
   resources/views/vendor/statamic/forms/fields/
   ```
   Each fieldtype maps to a file (e.g. `text.blade.php`, `select.blade.php`, `checkboxes.blade.php`).
3. Render fields in your Blade form template by outputting the pre-rendered `field` HTML:
   ```blade
   @foreach ($fields as $field)
     <div class="mb-2">
       <label class="block">{{ $field['display'] }}</label>
       {!! $field['field'] !!}
     </div>
   @endforeach
   ```
4. Customize per fieldtype template:
   - Respect variables Statamic provides (examples in the published files):
     - `$handle`, `$value`, `$validate`, `$options`, `$placeholder`, `$multiple`, `$max_files`, `$max_items`, `$inline`, etc.
   - Use Blade helpers for attributes:
     - `@required(in_array('required', $validate ?? []))`
     - `@checked(...)` / `@selected(...)`
5. Handle “multi” inputs correctly:
   - For files / assets or multi-select: append `[]` to `name` when multiple is allowed.
   - For checkbox groups: include a hidden input to ensure an empty array posts when nothing is checked.

## Pitfalls / gotchas
- **Escaping:** the pre-rendered field HTML must be echoed unescaped (`{!! ... !!}`) or the markup will be escaped.
- **Multiple values:** forgetting `[]` on multi-value names will drop values on submit.
- **Required flag:** Statamic passes validation rules; your template needs to apply `required` if you want native browser validation hints.

## Sources
- https://statamic.dev/frontend/blade-form-fields
- https://statamic.dev/frontend/forms
- https://statamic.dev/tags/form-create#prerendered-field-html
