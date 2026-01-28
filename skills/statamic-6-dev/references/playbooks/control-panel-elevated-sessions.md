# Control Panel: Elevated Sessions

**Summary:** Elevated sessions require users to re-verify (password/code) before sensitive actions. Statamic uses them for 2FA changes, role edits, user management. You can require them in JS or PHP.

**When to use:**
- Protecting sensitive addon/CP actions.

## Steps
1. JavaScript (Vue):
   ```js
   import { requireElevatedSession, requireElevatedSessionIf } from '@statamic/cms'

   requireElevatedSession()
     .then(() => { /* ok */ })
     .catch(() => {})

   requireElevatedSessionIf(condition)
   ```
2. PHP middleware:
   ```php
   use Statamic\Http\Middleware\CP\RequireElevatedSession;

   Route::get('profile', ...)->middleware(RequireElevatedSession::class);
   ```
3. Controller:
   - extend `Statamic\Http\Controllers\CP\CpController` and call:
     ```php
     $this->requireElevatedSession();
     ```

## Pitfalls / gotchas
- If user cancels the modal (JS), promise rejects; handle cleanly.

## Sources
- https://statamic.dev/control-panel/elevated-sessions
