# Backend & APIs: Query Scopes & Filters

**Summary:** This page is currently a placeholder in Statamic 6 docs. Filtering in practice is done via documented tag parameters, repository queries, and Laravel query capabilities when the selected driver supports them.

**When to use:**
- You need backend filtering beyond basic template usage.
- You are migrating older scope/filter patterns to 6.x-safe implementations.

## Steps
1. Start with documented filtering in tags and collection/entry query parameters where possible.
2. For addon/backend code, use repository-level query entry points for the resource type.
3. If you run database-backed storage, use Laravel query tooling where explicitly supported by the driver.
4. Validate filter behavior in both local and production-like data volumes.

## Pitfalls / gotchas
- Scope/filter examples from older docs may not map 1:1 to Statamic 6 internals.
- Mixing driver-specific assumptions can break portability across projects.

## Sources
- https://statamic.dev/backend-apis/query-scopes-filters
