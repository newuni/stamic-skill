# Control Panel: Permissions

**Summary:** Permissions are strings assigned to roles. Statamic ships with a default permission tree, and you can extend it (basic, nested, policy/wildcard-based, grouped). You can also inject permissions into existing core trees and override policies.

**When to use:**
- You’re building a role model for editors/admins.
- You’re adding project-specific or addon-specific capabilities.
- You need dynamic permissions per collection/site/etc.

## Steps
1. Register basic permissions inside `Permission::extend(...)`:
   ```php
   use Statamic\Facades\Permission;

   public function boot() {
     Permission::extend(function () {
       Permission::register('manage stuff')->label('Manage Custom Stuff');
     });
   }
   ```
2. Use nested permissions when some permissions should only be selectable after others.
3. Use policy-based wildcard permissions for “one permission per item” (e.g. per collection):
   - `view {collection} entries` with `replacements('collection', fn() => ...)`
   - ensure label uses `:collection` placeholder
4. Combine wildcard permissions + nested children to match Statamic’s permission trees.
5. Group permissions (create your own group or add to an existing one).
6. Add children to core permissions with `Permission::get(...)->addChild(...)` when needed.
7. Override policies by binding Statamic policy classes to your custom ones in `AppServiceProvider`.
   - If you need to bypass super-user shortcuts, adjust the `before()` method.

## Pitfalls / gotchas
- When using replacements, labels must include a `:placeholder`.
- Many built-in policies grant early access for super users; override `before()` if you must change that.

## Sources
- https://statamic.dev/control-panel/permissions
