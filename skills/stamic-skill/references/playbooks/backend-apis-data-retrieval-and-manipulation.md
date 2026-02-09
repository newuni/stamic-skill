# Backend & APIs: Data Retrieval and Manipulation

**Summary:** The Statamic 6 page for this topic is currently a placeholder. In practice, data access should be done through Statamic repositories/facades (entries, terms, assets, globals, users) and, where needed, Laravel query patterns supported by your storage driver.

**When to use:**
- You need programmatic access to Statamic content in addons or backend code.
- You are replacing assumptions from older backend API docs.

## Steps
1. Start from the concrete content type you need (entries, terms, assets, globals, users).
2. Use the corresponding Statamic repository/facade instead of building ad-hoc filesystem reads.
3. Keep retrieval logic explicit about site/locale/state (published, draft, etc.) when relevant.
4. For extension-level architecture decisions, consult the repositories/resource-APIs sections and current source.

## Pitfalls / gotchas
- Placeholder docs can hide version drift; validate behavior against current Statamic 6 APIs.
- Mixing storage assumptions (file vs database driver) can break generic retrieval code.

## Sources
- https://statamic.dev/backend-apis/data-retrieval-and-manipulation
