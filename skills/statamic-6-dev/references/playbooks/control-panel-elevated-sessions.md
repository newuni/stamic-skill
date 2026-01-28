# Control Panel: Elevated Sessions

**Summary:** Elevated Sessions require users to re-verify (password or code) before performing sensitive actions. Statamic uses them for things like 2FA changes and managing users/roles. You can integrate elevated session requirements in JS or PHP.

**When to use:**
- Addons/custom CP actions that should require re-auth.
- Protecting sensitive admin operations.

## Steps
### JavaScript
1. Use `requireElevatedSession()` before a sensitive action:
   - it opens a modal, resolves on success, rejects if cancelled.
2. Use `requireElevatedSessionIf(condition)` for conditional cases.

### PHP
1. Add middleware to routes:
   - `Statamic\Http\Middleware\CP\RequireElevatedSession::class`
2. Or in CP controllers (extending `CpController`), call `$this->requireElevatedSession()`.

## Pitfalls / gotchas
- Elevated sessions expire (default ~15 minutes).
- In PHP controller usage, you need to extend Statamic’s `CpController`.

## Sources
- https://statamic.dev/control-panel/elevated-sessions
