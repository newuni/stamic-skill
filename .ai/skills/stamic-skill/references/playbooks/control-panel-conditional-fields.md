# Control Panel: Conditional Fields

**Summary:** Conditional fields show/hide publish-form fields based on other values. Only visible fields are submitted (data flow), enabling conditional validation. Conditions can be YAML-based or custom JS conditions.

**When to use:**
- Simplify publish forms.
- Conditional validation and data capture.

## Steps
1. Add conditions to blueprint fields using `if/show_when` or `unless/hide_when`.
2. Common patterns:
   - boolean:
     ```yaml
     if:
       has_author: true
     ```
   - empty/not empty:
     ```yaml
     if:
       favorite_food: not empty
     ```
   - select equality:
     ```yaml
     if:
       post_type: video
     ```
   - contains / contains_any:
     ```yaml
     if:
       favorite_foods: 'contains_any pizza, lasagna'
     ```
   - comparisons:
     ```yaml
     if:
       age: '>= 16'
     ```
3. Combine conditions:
   - all must pass: `if:`
   - any can pass: `if_any:`
4. Nested values:
   - dot notation: `address.country: Canada`
5. Cross-context values:
   - use `$parent.` or `$root.`
6. Conditional validation:
   - use `sometimes` + `required`:
     ```yaml
     validate:
       - sometimes
       - required
     ```
7. Custom JS conditions:
   ```js
   Statamic.$conditions.add('isCanadian', ({ target }) => /eh|bud/.test(target))
   ```
   And in YAML:
   ```yaml
   if:
     quote: custom isCanadian
   ```

## Pitfalls / gotchas
- Only visible fields are submitted unless you enable `always_save` (see field data flow).
- Custom conditions only work in CP, not frontend forms.

## Sources
- https://statamic.dev/control-panel/conditional-fields
