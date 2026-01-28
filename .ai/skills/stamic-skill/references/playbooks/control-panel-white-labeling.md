# Control Panel: White Labeling

**Summary:** White Labeling lets you customize the CP branding: CMS name, logos (including dark mode variants), favicon, custom CSS, support link, and whether to show docs links.

**When to use:**
- Client/internal rebranding.

## Steps
1. Configure in `config/statamic/cp.php` (or env vars):
   - `custom_cms_name`
   - `custom_logo_url` (string or `{nav,outside}` array)
   - `custom_dark_logo_url`
   - `custom_logo_text`
   - `custom_favicon_url`
   - `custom_css_url`
   - `support_url` (or `false`)
   - `link_to_docs`
2. Use different logos for navbar vs login by providing an array.

## Pitfalls / gotchas
- License: you may rebrand for personal/internal/client use, not resell Statamic as another product.

## Sources
- https://statamic.dev/control-panel/white-labeling
