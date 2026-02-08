# Tags: Overview

**Summary:** Tags are Antlers expressions (and callable PHP methods under the hood) used to fetch/filter/display content, build forms, manipulate data, and add dynamic functionality. They exist as single tags and tag pairs, and can also be used from Blade via Antlers Blade Components.

**When to use:**
- Implementing common frontend features without writing controllers.
- Fetching entries/terms/assets and rendering lists.

## Steps
1. Use single tags for simple value output.
2. Use tag pairs when you need a loop/body (wrap markup).
3. Reach for common tags:
   - `collection:*` / `entries:*`
   - `taxonomy:*`
   - `assets:*`
   - `form:*`
   - `partial`
4. In Blade, use Antlers Blade Components (`<s:collection ...>`) when you want tag behavior.
5. When needed, build custom tags.

## Pitfalls / gotchas
- Tag naming/usage differs between Antlers and Blade contexts.

## Sources
- https://statamic.dev/tags/overview
