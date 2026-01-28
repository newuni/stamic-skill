# Advanced Topics: OAuth

**Summary:** Statamic supports OAuth login via Laravel Socialite. Configure providers to show buttons on CP login, and optionally use the `oauth:*` tag on the frontend to start the flow. Statamic can create users, merge user data, and lets you customize user creation/merged data.

**When to use:**
- CP login via Google/GitHub/etc.
- Frontend “Log in with …” that maps to Statamic users.

## Steps
1. Install Socialite:
   ```bash
   composer require laravel/socialite
   ```
2. Enable OAuth:
   - in `config/statamic/oauth.php` or `.env`:
     ```env
     STATAMIC_OAUTH_ENABLED=true
     ```
3. Configure providers in `config/statamic/oauth.php`:
   ```php
   'providers' => [
     'github' => 'GitHub',
     // or: 'saml2' => ['stateless' => true, 'label' => 'Okta'],
   ],
   ```
4. Add credentials in `config/services.php` (Socialite convention):
   ```php
   'github' => [
     'client_id' => env('GITHUB_CLIENT_ID'),
     'client_secret' => env('GITHUB_CLIENT_SECRET'),
     'redirect' => 'https://your-site.com/oauth/github/callback',
   ],
   ```
   Ensure callback URL matches your OAuth app settings.
5. Use it:
   - CP login will show provider buttons.
   - Frontend can link using the oauth tag:
     ```antlers
     <a href="{{ oauth:github }}">Log in with GitHub</a>
     ```
6. Customize user flow in `config/statamic/oauth.php`:
   - `create_user`, `merge_user_data`, `unauthorized_redirect`.
7. Third-party providers via SocialiteProviders:
   - `composer require socialiteproviders/<provider>`
   - register `SocialiteWasCalled` listener to `extendSocialite`.
8. Customize user data merge:
   ```php
   use Statamic\Facades\OAuth;

   OAuth::provider('github')
     ->withUserData(fn ($socialiteUser, $statamicUser) => [
       'name' => $socialiteUser->getName(),
     ]);
   ```
9. Customize full user creation (first-time):
   ```php
   use Statamic\Facades\User;
   use Statamic\Facades\OAuth;

   OAuth::provider('github')->withUser(fn ($u) =>
     User::make()->email($u->getEmail())->set('name', $u->getName())
   );
   ```

## Pitfalls / gotchas
- `withUserData` merges on **every** OAuth login (can overwrite fields).
- `withUser` is only used when initially creating the user.

## Sources
- https://statamic.dev/advanced-topics/oauth
