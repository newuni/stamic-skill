# Backend & APIs: Hooks

**Summary:** Hooks let you intercept specific points in Statamic’s PHP execution using a pipeline of closures. A payload is passed through registered closures (`$payload`, `$next`) so you can inspect/modify it.

**When to use:**
- You want to tweak core behavior/output without replacing whole classes.
- You want extension points for your own code (provide hooks others can use).

## Steps
1. Register a hook on a hookable class (tags/fieldtypes/resources/etc):
   ```php
   use Statamic\Tags\Collection;

   Collection::hook('fetched-entries', function ($entries, $next) {
     $entries = $entries->take(3);
     return $next($entries);
   });
   ```
2. If you need to run after other closures, call `$next` first:
   ```php
   Collection::hook('fetched-entries', function ($entries, $next) {
     $entries = $next($entries);
     $ids = $entries->pluck('id');
     return $entries;
   });
   ```
3. Know the closure scope:
   - closure is scoped to the originating class (`$this` acts like the class instance).
4. Use the docs list of built-in hooks (examples include tags init, collection fetched-entries, form tag hooks, augmentation, bard lifecycle, CP listing queries, static cache warming, etc.).
5. Trigger your own hook pipeline:
   - use `Hookable` trait + `$this->runHooks('hook-name', $payload)`
   - consumers register with `YourClass::hook('hook-name', fn ($payload, $next) => ...)`.

## Pitfalls / gotchas
- Treat hooks as pipelines: always return `$next($payload)` (or return the final payload) so downstream closures receive the value.

## Sources
- https://statamic.dev/backend-apis/hooks
