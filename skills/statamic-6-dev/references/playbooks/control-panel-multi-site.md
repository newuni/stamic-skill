# Control Panel: Multi-Site

**Summary:** Multi-site lets one Statamic install manage variations of a single site (languages/regions/domains/subdomains/subdirectories). It’s not intended for hosting many independent tenant sites. Sites are configured in `resources/sites.yaml` and enabled via `config/statamic/system.php`.

**When to use:**
- Translations or region-specific site variants.
- Different domains/subdomains/subpaths for the same product/site.

## Steps
1. If converting an existing single-site install, run:
   ```bash
   php please multisite
   ```
2. Enable multi-site:
   - `config/statamic/system.php` → `'multisite' => true`
3. Add sites via the CP (Sites) or edit `resources/sites.yaml`:
   - per site: `name`, `url`, `locale`, optional `lang`, optional `attributes`
4. Prefer explicit/absolute site URLs (often based on `{{ config:app:url }}`) and control them per environment via `APP_URL`.
5. Be careful renaming site handles; update content folders and any configs that reference the handle.
6. Permissions:
   - add `access {site_handle} site` to roles as needed; site access gates CP editing.
7. Optional: per-site views:
   - `resources/views/<site_handle>/...` overrides root views when present.
8. Template snippets:
   - site switcher: loop `{{ sites }}`
   - set `<html lang="{{ site:short_locale }}">`
9. Enable fields for localization using the field “Localizable” (globe icon).

## Pitfalls / gotchas
- Not a multi-tenant feature; don’t use it to host unrelated sites.
- Static caching in multi-site requires additional config + rewrite rules (see static caching docs).

## Sources
- https://statamic.dev/control-panel/multi-site
