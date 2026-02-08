# Backend & APIs: Blink Cache

**Summary:** Blink is a per-request cache for expensive operations. Values live only for the lifetime of a single request. Statamic uses Spatie Blink under the hood.

**When to use:**
- Memoizing expensive computations within one request.
- Avoiding duplicate DB/API work during a single page render.

## Steps
1. Basic get/put:
   ```php
   use Statamic\Facades\Blink;

   Blink::put('key', 'value');
   $value = Blink::get('key');
   ```
2. Memoize with `once`:
   ```php
   use Statamic\Facades\Blink;

   $value = Blink::once('random', fn () => rand());
   ```
   Subsequent calls with the same key return the cached value (within the same request).
3. Use stores to avoid key conflicts or to flush independently:
   ```php
   Blink::store('mystore')->put('key', 'value');
   ```

## Pitfalls / gotchas
- This is **not** persisted across requests.
- If you don’t choose a store, you use the shared `default` store.

## Sources
- https://statamic.dev/backend-apis/blink-cache
- https://github.com/spatie/blink
