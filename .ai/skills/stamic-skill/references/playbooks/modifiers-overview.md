# Modifiers: Overview

**Summary:** Modifiers transform variable values in Antlers templates using pipe syntax, and can be chained (left to right). In Blade you can use the fluent modifier API (`Statamic::modify(...)`).

**When to use:**
- Formatting or transforming output in templates (strings, arrays, dates).
- Simplifying markup or debugging.

## Steps
1. Apply modifiers in Antlers:
   - `{{ title | upper | widont }}`
2. Chain modifiers in the needed order (order matters).
3. In Blade, use fluent modifiers:
   - `{!! Statamic::modify($value)->markdown()->upper()->widont() !!}`
4. Use the reference list to find available modifiers; build custom ones if needed.

## Pitfalls / gotchas
- Modifiers are Antlers-only in syntax; use the fluent API in Blade.

## Sources
- https://statamic.dev/modifiers/overview
