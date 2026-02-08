# Knowledge Base: Timezones

**Summary:** Store dates in **UTC**, convert only at display time. Statamic can apply a `display_timezone` and provides ways to ensure modifiers/tags use the localized timezone when needed.

**When to use:**
- You see “off by X hours” issues in templates.
- You have multi-timezone audiences.

## Steps
1. Keep storage in UTC (recommended).
2. Set display timezone in `config/statamic/system.php`:
   ```php
   'display_timezone' => 'Europe/Madrid',
   ```
3. Understand templating behavior:
   - Carbon instances are UTC internally.
   - When cast to string, Statamic converts to `display_timezone`.
4. Modifiers:
   - modifiers like `format` receive UTC unless you localize:
     - use `tz` modifier:
       ```antlers
       {{ date | tz | format('Y-m-d H:i') }}
       ```
     - or enable automatic localization for date modifiers:
       ```php
       'localize_dates_in_modifiers' => true,
       ```
5. Tags:
   - if a tag truly needs localized time, pass localized value:
     ```antlers
     {{ my_tag :date="date|tz" }}
     ```
6. Custom routes:
   - ensure the `Localize` middleware is applied (Route::statamic() / `statamic.web` already includes it).

## Pitfalls / gotchas
- Automatic localization happens when converting Carbon → string, not when passing values into modifiers/tags.

## Sources
- https://statamic.dev/knowledge-base/tips/timezones
