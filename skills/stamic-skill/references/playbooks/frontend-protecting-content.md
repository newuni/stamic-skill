# Frontend: Protecting Content

**Summary:** Statamic can protect frontend content per-entry, per-collection, or site-wide using protection schemes configured in `config/statamic/protect.php`. Built-in drivers: `auth`, `ip_address`, `password`. You can build custom drivers.

**When to use:**
- Staging site access control.
- Member-only sections.
- Temporary password protection.

## Steps
1. Protect a single entry via front matter:
   ```yaml
   protect: logged_in
   ```
2. Protect a whole collection via collection config injection:
   ```yaml
   inject:
     protect: logged_in
   ```
3. Configure schemes in `config/statamic/protect.php`:
   - IP allowlist:
     ```php
     'ip_only' => [
       'driver' => 'ip_address',
       'allowed' => ['127.0.0.1'],
     ],
     ```
   - Auth:
     ```php
     'logged_in' => [
       'driver' => 'auth',
       'login_url' => '/login',
       'append_redirect' => true,
     ],
     ```
   - Password:
     ```php
     'password' => [
       'driver' => 'password',
       'allowed' => ['secret'],
       'form_url' => null,
       // optional: 'field' => 'password',
     ],
     ```
4. Password driver UX:
   - override the built-in password view by creating:
     - `vendor/statamic/auth/protect/password.antlers.html` or
     - `vendor/statamic/auth/protect/password.blade.php`
   - build a form using `protect:password_form` (input name must be `password`).
   - optionally set `form_url` to host your own page/route.
5. Endgame: block everyone by setting:
   ```yaml
   protect: true
   ```
6. Site-wide protection: set `default` scheme in `protect.php`.
7. Custom drivers:
   - implement a class extending `Statamic\Auth\Protect\Protectors\Protector` with `protect()`.
   - register via `ProtectorManager::extend('driver_name', fn() => new YourProtector)`.

## Pitfalls / gotchas
- Protection applies only to Statamic-routed frontend content (entries/terms/etc). Laravel `routes/web.php` routes are unaffected.
- Protected pages are excluded from Static Caching.
- Password protection is “good enough for staging”, not hardened security.

## Sources
- https://statamic.dev/frontend/protecting-content
