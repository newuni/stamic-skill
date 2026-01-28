# Advanced Topics: Lifecycle

**Summary:** Statamic runs inside Laravel’s request lifecycle. Key extension points:
- Laravel service providers `register()` (bindings) and `boot()` (bootstrapping)
- after-app-boot for permissions/auth-related registration
- CP view composition for exposing config to JS
- Control Panel Vue lifecycle: `Statamic.booting()` (register globals) then `Statamic.booted()` (post-boot wiring)

**When to use:**
- You’re unsure where to register permissions, components, callbacks, bard extensions, etc.

## Steps
1. In Laravel service providers:
   - Put container bindings in `register()`.
   - Put runtime boot logic in `boot()`.
2. For permissions/auth additions, run after Statamic sets up permissions:
   ```php
   public function boot()
   {
     $this->app->booted(function () {
       // Permission::register(...)
     });
   }
   ```
3. Provide server-side config to the CP JS:
   ```php
   View::composer('statamic::layout', function () {
     Statamic::provideToScript(['foo' => 'bar']);
   });
   ```
   JS side:
   ```js
   Statamic.$config.get('foo')
   ```
4. CP Vue lifecycle:
   - register global components before Vue app creates:
     ```js
     Statamic.booting(() => {
       Statamic.$components.register('my-component', MyComponent)
     })
     ```
   - wire up things after Vue boot:
     ```js
     Statamic.booted(() => {
       // bard extensions, hooks, js events
     })
     ```

## Pitfalls / gotchas
- The Vue lifecycle portion applies only to **Control Panel** requests.

## Sources
- https://statamic.dev/advanced-topics/lifecycle
