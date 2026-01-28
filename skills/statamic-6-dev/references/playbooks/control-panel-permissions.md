# Control Panel: Permissions (Extending)

**Summary:** Permissions are strings that can be assigned to roles. Statamic ships many core permissions, and you can register your own (including nested trees and wildcard/policy-based permissions) in a service provider.

**When to use:**
- Custom features in the CP need role-based access.
- Addons must add permissions.

## Steps
1. Register a basic permission (wrap in `Permission::extend`):
   ```php
   use Statamic\Facades\Permission;

   public function boot()
   {
     Permission::extend(function () {
       Permission::register('manage stuff')->label('Manage Custom Stuff');
     });
   }
   ```
2. Create nested permission trees using `children()`:
   ```php
   Permission::register('view blog entries', function ($permission) {
     $permission->children([
       Permission::make('edit blog entries')->children([
         Permission::make('create blog entries'),
         Permission::make('delete blog entries'),
       ]),
     ]);
   });
   ```
3. Create wildcard/policy-style permissions with `replacements()`:
   ```php
   Permission::register('view {collection} entries', function ($permission) {
     $permission
       ->label('View :collection entries')
       ->replacements('collection', function () {
         return Collection::all()->map(fn ($c) => ['value' => $c->handle(), 'label' => $c->title()]);
       });
   });
   ```
4. Use policies for authorization checks (Laravel style) using the resolved permission string.
5. Group permissions:
   ```php
   Permission::group('myaddon', 'My Addon', function () {
     Permission::make('manage myaddon');
   });
   ```
6. Inject into core permission tree via `addChild()` on existing permissions.
7. Override core policies by binding a custom policy class in your service provider `register()`.

## Pitfalls / gotchas
- With replacements, ensure the label contains the `:placeholder` token.
- Super-user logic may grant access early; override `before()` if needed.

## Sources
- https://statamic.dev/control-panel/permissions
