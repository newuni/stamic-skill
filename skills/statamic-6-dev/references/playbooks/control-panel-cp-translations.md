# Control Panel: Translations (CP translations)

**Summary:** Statamic’s Control Panel UI is translated into many languages. Configure the default locale in `config/app.php`, optionally set a fallback locale, and override per user via user preferences. Some strings fall back to Laravel/app translations.

**When to use:**
- You want the CP UI in a specific language.
- You need per-user UI language preferences.
- You need to contribute or maintain a translation.

## Steps
1. Set default locale (and fallback) in `config/app.php`:
   - `'locale' => 'es'`
   - `'fallback_locale' => 'en'`
2. Override per user by setting `preferences.locale` in the user record YAML.
3. For translations not covered by Statamic (e.g., Laravel auth/validation strings), provide translations in your app’s `resources/lang`.
   - Consider using Laravel-lang as a starting point.
4. Contribute a new translation (upstream):
   - clone `statamic/cms`, install deps
   - generate files: `php translator generate <code>`
   - translate JSON/PHP lang files
   - add language to CorePreferences list
   - submit PR

## Pitfalls / gotchas
- Community translations can lag behind new Statamic releases.

## Sources
- https://statamic.dev/control-panel/cp-translations
