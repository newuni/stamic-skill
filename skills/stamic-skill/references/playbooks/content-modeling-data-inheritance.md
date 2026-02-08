# Content Modeling: Data Inheritance (The Cascade)

**Summary:** Statamic resolves variables via an ordered fallback chain called “the cascade”. If a variable isn’t defined in the current scope, Statamic checks successive scopes (partial params, view model, entry, origin, collection inject, globals, system variables) until it finds a value or returns null.

**When to use:**
- Debugging “why is this variable value coming from *there*?”
- Designing templates that should work across different pages/entries without repetition.

## Steps
1. Use null-coalescing in templates to pick the first available value:
   - Antlers: `{{ nav_title ?? breadcrumb_title ?? title }}`
   - Blade: `{{ $nav_title ?? $breadcrumb_title ?? $title }}`
2. Know the cascade order (high level):
   1) variables explicitly passed into partials
   2) ViewModels
   3) entry fields
   4) origin entry (for localized entries)
   5) collection `inject` defaults
   6) globals
   7) system variables
3. When debugging:
   - check whether you’re inside a partial with passed-in params
   - check view models
   - inspect entry front matter and blueprint-defined fields
   - check collection YAML `inject:`
   - check globals

## Pitfalls / gotchas
- “Missing” variables won’t throw errors; they resolve to null, so silent failures can happen if you assume a value exists.

## Sources
- https://statamic.dev/content-modeling/data-inheritance
