# Control Panel: Multi-Site

**Summary:** Multi-site lets one Statamic install serve multiple “sites” (languages/regions/brands) with separate URLs/locales. Configure sites in `resources/sites.yaml` (or CP UI), enable multisite in `config/statamic/system.php`, and manage per-site permissions and templates.

**When to use:**
- Translations.
- Country/region variants.
- Same codebase, multiple site variants (not multi-tenant).

## Steps
1. Convert an existing single-site install:
   ```bash
   php please multisite
   ```
2. Enable multisite:
   - `config/statamic/system.php`:
     ```php
     'multisite' => true,
     ```
3. Define sites in `resources/sites.yaml`:
   ```yaml
   en:
     name: English
     url: '{{ config:app:url }}'
     locale: en_US
     lang: en
     attributes:
       theme: standard
   fr:
     name: Français
     url: '{{ config:app:url }}/fr/'
     locale: fr_FR
   ```
4. Understand site options:
   - handle (key), name (label), url (base), locale (formatting), lang (CP language), attributes (arbitrary values)
5. Per-site permissions:
   - grant `access {site_handle} site` on roles.
6. Per-site views:
   - put view overrides in `resources/views/{site_handle}/...`.
7. Build a site switcher using the `sites` loop.
8. Static caching + multisite requires additional config and server rules (see static caching multisite section).
9. Localize fields (globe icon) to edit per-site values.

## Pitfalls / gotchas
- Renaming a site handle requires moving content directories and updating collection configs.

## Sources
- https://statamic.dev/control-panel/multi-site
