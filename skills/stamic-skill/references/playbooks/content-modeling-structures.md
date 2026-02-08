# Content Modeling: Structures

**Summary:** Structures are hierarchical trees used for navigation and (optionally) to dictate URL structure for “orderable” collections (the modern replacement for Statamic v2 Pages). There are two flavors: structured collections and navs.

**When to use:**
- You want a Pages-like tree where ordering/nesting controls URLs.
- You want a navigation tree that can mix entry references, URLs, and text nodes.

## Steps
1. Decide which flavor you need:
   - **Structured collection**: for Pages-like hierarchies where the tree dictates URLs.
   - **Nav**: for menus that can include entry refs, URLs, and text.
2. Structured collections:
   - enable “Orderable” on the collection
   - tree stored in `content/trees/collections/`
   - parent/child structure makes `parent_uri` and `depth` available for routes
3. Navs:
   - config stored in `content/navigation/`
   - tree stored in `content/trees/navigation/`
   - can reuse the same entry multiple times
4. Render with the `nav` tag.
5. Edit trees in the Control Panel (recommended) or directly in YAML.
6. Control nesting depth via `max_depth`.

## Pitfalls / gotchas
- Structured collections allow placing an entry only once; navs can place the same entry multiple times.
- In structured collections, the arrangement affects URLs; changing the tree can change URLs.

## Sources
- https://statamic.dev/content-modeling/structures
