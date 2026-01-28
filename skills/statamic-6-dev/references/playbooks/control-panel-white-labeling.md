# Control Panel: White Labeling

**Summary:** White labeling lets you customize Control Panel branding (name, logos, colors, favicon, custom CSS) and optionally hide doc links / set a support URL. It’s configured in `config/statamic/cp.php` (and/or env vars).

**When to use:**
- Delivering Statamic to a client with their branding.
- Customizing the CP look/feel for internal use.

## Steps
1. Configure white label options in `config/statamic/cp.php` (or equivalent env vars).
2. Set a custom CMS name:
   - `custom_cms_name`
3. Set logo(s):
   - `custom_logo_url` (single URL or array for nav/outside)
   - `custom_dark_logo_url` for dark mode
   - alternatively use `custom_logo_text`
4. Set favicon and custom CSS:
   - `custom_favicon_url`
   - `custom_css_url`
5. Configure support & docs links:
   - `support_url` (or `false` to remove)
   - `link_to_docs`

## Pitfalls / gotchas
- License terms: you can only rebrand for personal/internal/client usage; you cannot resell Statamic under another name.

## Sources
- https://statamic.dev/control-panel/white-labeling
