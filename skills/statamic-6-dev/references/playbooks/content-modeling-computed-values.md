# Content Modeling: Computed Values

**Summary:** Computed values are virtual fields (like Eloquent accessors) defined in code for entries and users. They can pull from APIs/DBs or derive from other fields. You can show them in the Control Panel by adding a field with the same handle and setting Visibility to “Computed”.

**When to use:**
- You need derived/dynamic data (e.g., share counts, balances, computed URLs).
- You want to show read-only computed data in publish forms or listings.

## Steps
1. Define computed values in a service provider `boot()` using the relevant facade:
   - Users: `Statamic\Facades\User::computed(...)`
   - Entries/collections: `Statamic\Facades\Collection::computed(...)`
2. Implement callback signature: `(object $instance, $value)` where `$value` is a stored override if present.
3. Optionally define the same computed value for multiple collections.
4. Cache expensive computations (API calls, heavy local work) using Laravel Cache.
5. Access computed values as properties (e.g. `$entry->shares`).
6. To display in the Control Panel:
   - add a field with the computed handle to the blueprint
   - set field Visibility to **Computed** (read-only; will not store on save)
   - optionally mark it Listable to show it in listings

## Pitfalls / gotchas
- Computed values are only available for top-level fields (not inside Replicator/Grid).
- Computed values can’t be queried as they’re evaluated after the query executes.

## Sources
- https://statamic.dev/content-modeling/computed-values
