# Control Panel: Toast Notifications

**Summary:** Toasts are small notification popups in the CP. You can trigger them from Vue (`this.$toast`) or from PHP using the `Toast` facade; they are automatically carried through the response into JavaScript.

**When to use:**
- Showing success/error/info after actions, utilities, controllers.

## Steps
1. In Vue:
   ```js
   this.$toast.info('message')
   this.$toast.success('message')
   this.$toast.error('message')
   this.$toast.success('message', { duration: 3000 })
   ```
2. In PHP:
   ```php
   use Statamic\Facades\CP\Toast;

   Toast::info('message');
   Toast::success('message');
   Toast::error('message');
   Toast::info('message')->duration(3000);
   ```

## Pitfalls / gotchas
- If you return your own response early, ensure the toast is still part of the response lifecycle (Statamic handles it when you just call the facade).

## Sources
- https://statamic.dev/control-panel/toast-notifications
