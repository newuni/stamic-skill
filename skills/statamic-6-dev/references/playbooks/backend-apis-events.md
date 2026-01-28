# Backend & APIs: Events

**Summary:** Statamic dispatches many Laravel events throughout the CMS lifecycle (entries, assets, blueprints, forms, navs, globals, licensing, etc.). Use standard Laravel listeners/subscribers to react to them, decouple logic, or alter behavior (sometimes by mutating objects on the event). Addons can register listeners/subscribers in their addon service provider.

**When to use:**
- Reacting to content changes (saved/created/deleted).
- Updating search indexes, clearing caches, syncing third-party services.
- Enforcing rules or preventing operations (events that allow returning `false`).

## Steps
1. Create a listener:
   ```php
   use Statamic\Events\EntrySaved;

   class WhenEntrySaved
   {
     public function handle(EntrySaved $event)
     {
       $entry = $event->entry;
     }
   }
   ```
2. Register listeners in `app/Providers/EventServiceProvider.php` (`$listen`) for apps.
3. For addons:
   - place listeners in `src/Listeners` or subscribers in `src/Subscribers` (autoloaded by Statamic conventions), or
   - register manually in the addon service provider.
4. Consult the “Available Events” list to pick the correct event class.

## Pitfalls / gotchas
- Some “*Saving/*Creating/*Deleting” events allow returning `false` to prevent the operation.
- `EntrySaved` can fire per localization; use `$event->isInitial()` when relevant.

## Sources
- https://statamic.dev/backend-apis/events
