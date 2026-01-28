# Control Panel: Preferences

**Summary:** Preferences are CP-only settings that can be set per default, per role, and per user. They’re stored as YAML (defaults in `resources/preferences.yaml`, role/user preferences alongside their role/user data). Preferences can be extended with custom fields.

**When to use:**
- You want consistent CP defaults for a team.
- You need role-based defaults (editors vs admins).
- You want custom theme/locale/start-page behavior.

## Steps
1. Users manage their own preferences via the CP (cog icon).
2. To manage defaults/role prefs for others: enable Pro and ensure you’re a super user or have `manage preferences` permission.
3. Understand precedence:
   - Default preferences
   - Role preferences (primary/first role wins if user has multiple)
   - User preferences
4. Storage:
   - defaults: `resources/preferences.yaml`
   - roles/users: stored in their respective YAML under a `preferences` key
5. Themes:
   - choose or create themes (Tailwind palette-based)
   - themes can be shared/published
6. Extend preferences with custom fields via a service provider using `Preference::extend(...)` returning sections/tabs.
7. Get/set values:
   - PHP: `Preference::get($key, $fallback)`; set via `Preference::default()->set(...)->save()` etc.
   - JS: `this.$preferences.get(...)` / `this.$preferences.set(...).then(...)`

## Pitfalls / gotchas
- JS can only set user preferences (not role/default).

## Sources
- https://statamic.dev/control-panel/preferences
