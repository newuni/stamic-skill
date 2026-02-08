# Control Panel: Extending CP Navigation (Addons)

**Summary:** Addons can extend the CP sidebar navigation using the `Nav` facade. You can add, remove, or modify nav items (and children), set icons, routes/URLs, authorization, and breadcrumb extras.

**When to use:**
- Addon adds a new CP section/page.
- Customize existing nav items.

## Steps
1. Extend nav in your addon service provider (typically `bootAddon()`):
   ```php
   use Statamic\Facades\CP\Nav;

   public function bootAddon()
   {
     Nav::extend(function ($nav) {
       $nav->content('Store')
         ->route('store.index')
         ->icon('shopping-cart');
     });
   }
   ```
2. If section name has special characters, use `create()->section(...)`.
3. Add children:
   ```php
   ->children([
     'Products' => cp_route('store.products.index'),
     'Orders' => cp_route('store.orders.index'),
   ])
   ```
   Or create `NavItem` objects for more control (e.g. `can()` permissions).
4. Remove items:
   - `$nav->remove('Content', 'Store');`
   - remove child: `$nav->remove('Content', 'Collections', 'Products');`
   - remove section: `$nav->remove('Content');`
5. Modify existing items:
   - `$nav->content('Collections')->icon('coins');`
   - or `findOrCreate(section, item)`.
6. Breadcrumb extras:
   - `->extra(['breadcrumbs' => ['create_label' => ..., 'create_url' => ...]])`
   - push extra breadcrumbs from controllers using `Breadcrumbs::push(...)`.

## Pitfalls / gotchas
- Use `Statamic\Facades\CP\Nav` (not the frontend Nav facade).

## Sources
- https://statamic.dev/extending/cp-navigation
