# Control Panel: Translations

**Summary:** Statamic’s Control Panel ships with many languages. Set app locale/fallback in `config/app.php`, optionally override per-user locale in user preferences, and contribute new translations via statamic/cms.

**When to use:**
- CP localization for editors.

## Steps
1. Set default locale and fallback in `config/app.php`:
   ```php
   'locale' => 'es',
   'fallback_locale' => 'en',
   ```
2. Per-user override:
   - in a user’s YAML record preferences:
     ```yaml
     preferences:
       locale: en
     ```
3. Know what isn’t covered:
   - some auth/validation strings come from Laravel app translations (`resources/lang`).
   - consider copying from https://github.com/Laravel-Lang/lang.
4. Contribute a new translation:
   - clone `statamic/cms`, run `composer install`.
   - generate files:
     ```bash
     php translator generate <code>
     ```
   - translate generated `lang/<code>` and `<code>.json`.
   - add language option to `CorePreferences` list.

## Pitfalls / gotchas
- Community translations may lag behind new releases.

## Sources
- https://statamic.dev/control-panel/cp-translations
