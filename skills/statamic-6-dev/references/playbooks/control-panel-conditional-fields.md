# Control Panel: Conditional Fields

**Summary:** Conditional fields let you show/hide fields on publish forms based on other field values. Conditions are defined per-field in blueprints using `if/show_when` (show) or `unless/hide_when` (hide). Data flow matters: hidden fields generally aren’t submitted unless you opt into `always_save` or use a Revealer.

**When to use:**
- You want cleaner publish forms (only show what’s relevant).
- You want conditional validation (required only when shown).
- You need advanced condition logic in the CP.

## Steps
1. Add conditions to a field in a blueprint using `if:` (or `show_when:`) / `unless:` (or `hide_when:`).
2. Use common condition types:
   - boolean: `if: { toggle: true }`
   - empty/not empty
   - equality via select values
   - contains / contains_any (arrays or substrings)
   - numeric comparisons (`>= 16`, etc.)
3. Combine conditions:
   - all-of: multiple keys under `if:`
   - any-of: use `if_any:`
4. Reference nested data with dot notation (e.g. `address.country: Canada`).
5. If you’re inside nested fields (Replicator/Grid) and need parent/root context:
   - `$parent.` or `$root.` prefixes.
6. Handle data flow:
   - hidden-by-conditions fields are not submitted
   - if you need them submitted, use `always_save` (see field data flow docs) or use a Revealer for cosmetic hiding.
7. Conditional validation pattern:
   - add `sometimes` + `required` so required only applies when field is present.
8. For CP-only complex logic, register custom JS conditions via `Statamic.$conditions.add(...)`.

## Pitfalls / gotchas
- Custom JS conditions work only in the Control Panel, not frontend forms.
- Conditional hiding can prevent values from saving; be deliberate about `always_save`.

## Sources
- https://statamic.dev/control-panel/conditional-fields
