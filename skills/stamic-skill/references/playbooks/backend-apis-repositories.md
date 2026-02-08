# Backend & APIs: Repositories

**Summary:** Statamic uses a repository pattern so high-level APIs (e.g. `Entry::whereCollection('blog')`) don’t assume storage details. By default, repositories typically read from the Stache (file-backed DB). You can swap repositories to change storage (e.g. database) or bind custom data classes/query builders.

**When to use:**
- You’re changing where data is stored/retrieved (filesystem → database, external source).
- You need custom item/query classes.

## Steps
1. Swap a repository implementation in a service provider `register()`:
   ```php
   use Statamic\Contracts\Entries\EntryRepository;
   use Statamic\Statamic;

   public function register()
   {
     Statamic::repository(EntryRepository::class, DatabaseEntryRepository::class);
   }
   ```
2. If you only need small changes, extend the default Stache repository:
   ```php
   use Statamic\Stache\Repositories\EntryRepository as StacheEntryRepository;

   class MyEntryRepository extends StacheEntryRepository {}
   ```
3. Provide custom data classes via repository `bindings()`:
   ```php
   public static function bindings(): array
   {
     return [
       Statamic\Contracts\Entries\Entry::class => DatabaseEntry::class,
       Statamic\Contracts\Entries\QueryBuilder::class => DatabaseEntryQueryBuilder::class,
     ];
   }
   ```
4. Alternatively, bind only the item class (without swapping repository) in `boot()` so it wins:
   ```php
   $this->app->bind(Statamic\Contracts\Entries\Entry::class, CustomEntry::class);
   ```
5. Clear caches after changing bindings.

## Pitfalls / gotchas
- Prefer binding changes in `boot()` when you need to override bindings after everything else.

## Sources
- https://statamic.dev/backend-apis/repositories
