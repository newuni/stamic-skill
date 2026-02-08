# Frontend: GraphQL API

**Summary:** Statamic’s GraphQL API is a **read-only JSON API** for delivering content via GraphQL. It’s disabled by default; enable GraphQL and selectively enable resources. When enabled, GraphiQL is available in the Control Panel.

**When to use:**
- Headless usage with flexible querying.
- You want schema-driven content selection.

## Steps
1. Enable GraphQL:
   - `.env`:
     ```env
     STATAMIC_GRAPHQL_ENABLED=true
     ```
   - or `config/statamic/graphql.php`:
     ```php
     'enabled' => true,
     ```
2. Enable resources (security: disabled by default):
   ```php
   'resources' => [
     'collections' => true,
     'taxonomies' => true,
     // ...
   ]
   ```
   Or enable specific sub-resources:
   ```php
   'collections' => ['articles' => true, 'pages' => true],
   ```
3. Use GraphiQL in the Control Panel to explore the schema.
4. Understand interface vs implementations:
   - common interfaces: `EntryInterface`, `TermInterface`, `AssetInterface`, `GlobalSetInterface`
   - blueprint-specific types require fragments (`... on Entry_Pages_Home { ... }`).
5. Use root queries (examples):
   - `entries`, `entry`, `collections`, `collection`, `terms`, `term`, `assets`, `asset`, `globalSets`, `globalSet`, `navs`, `nav`, `forms`, `form`, `users`, `user`, plus `ping`.
6. Pagination/filtering/sorting:
   - many queries support `limit`, `page`, `filter`, `sort`.
   - filtering must be explicitly enabled via `allowed_filters` like REST.
7. Add custom queries:
   - app config:
     ```php
     'queries' => [MyCustomQuery::class]
     ```
   - or in code (good for addons):
     ```php
     GraphQL::addQuery(MyCustomQuery::class);
     ```

## Pitfalls / gotchas
- GraphQL recursion limits: trees need explicit depth/fragments (can’t do infinite recursion).
- If you publish the underlying package config, routes may be enabled regardless of Statamic’s config (per docs).

## Sources
- https://statamic.dev/frontend/graphql
- https://statamic.dev/graphql
