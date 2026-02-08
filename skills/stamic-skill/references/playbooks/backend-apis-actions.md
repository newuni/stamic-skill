# Backend & APIs: Actions

**Summary:** Actions are bulk operations you can run on one or more items from CP listings (multi-select) or item menus. Implement actions by extending `Statamic\Actions\Action`, optionally add confirmation fields, authorization, redirects/downloads, and custom JS callbacks.

**When to use:**
- Bulk operations on Entries/Assets/Users/etc from CP listings.
- Admin workflows like export, publish, archive, sync.

## Steps
1. Generate an action:
   ```bash
   php please make:action
   ```
   Creates a class under `App\Actions` (auto-registered).
2. Implement `run($items, $values)`:
   - `$items` is a Collection of selected items.
   - `$values` are values entered into the confirmation dialog (if you added fields).
3. Optional: add confirmation dialog fields:
   - define `protected $fields = [...]` or override `fieldItems()`.
   - use `$this->context` when you need listing-specific context.
4. Optional: limit applicability:
   - `visibleTo($item)` to filter by item type.
   - `authorize($user, $item)` for per-item permission.
5. Optional: customize appearance:
   - `public static function title()`
   - `protected $icon = 'trash'`
   - `protected $dangerous = true`
6. Optional: redirect or download:
   - override `redirect($items, $values)`
   - override `download($items, $values)`
7. Return values (responses):
   - `null` → generic toast
   - `string` → toast message
   - `['message' => '...', ...]` → toast + extra payload to JS
   - `['callback' => ['name', 'arg1', ...]]` → run registered JS callback
   - `['message' => false]` → disable toast

## Pitfalls / gotchas
- Don’t put authorization logic in `visibleTo`; use `authorize`.

## Sources
- https://statamic.dev/backend-apis/actions
