# Backend & APIs: Resource APIs

**Summary:** The Resource APIs overview page is currently a stub in Statamic 6 docs. Use the concrete repository/resource pages and current source references for implementation details.

**When to use:**
- You need API-level access to core resources (entries, terms, assets, globals, users, etc.).
- You are designing addon internals that read/write Statamic resources programmatically.

## Steps
1. Start from the concrete resource repository page for the type you are working with.
2. Prefer repository contracts/patterns over direct low-level storage coupling.
3. Keep read/write logic explicit around site, localization, and publish state.
4. Validate behavior in your actual storage mode and deployment workflow.

## Pitfalls / gotchas
- The overview page being a stub can give a false sense that APIs are undocumented; the concrete repository pages are the actionable source.
- Cross-resource assumptions (entries vs terms vs assets) often break when reused blindly.

## Sources
- https://statamic.dev/backend-apis/resource-apis
