# Control Panel: Routing (Custom CP routes)

**Summary:** You can register custom Control Panel routes to build CP pages in an app. Use `Statamic::pushCpRoutes` to load a routes file; Statamic applies the correct middleware and name prefix.

**When to use:**
- App-level CP pages (not addon). For addons use addon routing.

## Steps
1. Create a CP routes file (e.g. `routes/cp.php`).
2. In `AppServiceProvider::boot()` push CP routes:
   ```php
   use Illuminate\Support\Facades\Route;
   use Statamic\Statamic;

   public function boot()
   {
     Statamic::pushCpRoutes(function () {
       Route::namespace('\\App\\Http\\Controllers')->group(function () {
         require base_path('routes/cp.php');
       });
     });
   }
   ```
3. Define your routes inside `routes/cp.php`.

## Pitfalls / gotchas
- This is for apps; addons should use `src/routes/cp.php` + addon provider routing.

## Sources
- https://statamic.dev/control-panel/routing
- https://statamic.dev/addons/building-an-addon#routing
