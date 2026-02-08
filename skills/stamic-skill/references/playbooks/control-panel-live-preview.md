# Control Panel: Live Preview

**Summary:** Live Preview renders an entry’s in-progress changes in real time while editing in the Control Panel. You can configure device sizes, preview targets (different URLs), toolbar inputs, and headless integrations.

**When to use:**
- Content authors need WYSIWYG-ish preview.
- Headless preview (Nuxt/Next/etc.) with preview mode.

## Steps
1. Ensure cache driver compatibility:
   - Live Preview **does not work** with Laravel’s `array` cache driver.
2. Configure device sizes in `config/statamic/live_preview.php`:
   ```php
   'devices' => [
     'Laptop' => ['width' => 1440, 'height' => 900],
     'Tablet' => ['width' => 1024, 'height' => 786],
     'Mobile' => ['width' => 375, 'height' => 812],
   ],
   ```
3. Add custom toolbar inputs (Vue components) in `config/statamic/live_preview.php`:
   ```php
   'inputs' => [
     'show_ads' => 'live-preview-ads',
   ],
   ```
   Register the component in CP JS:
   ```js
   Statamic.booting(() => {
     Statamic.$components.register('live-preview-ads', LivePreviewAds)
   })
   ```
   Use in templates via `live_preview:*`:
   ```antlers
   {{ if live_preview:show_ads }} ... {{ /if }}
   ```
4. Define preview targets per collection (so you can preview “Entry page” + “Index page” etc):
   ```yaml
   preview_targets:
     - label: Entry
       url: /blog/{slug}
     - label: Index
       url: /blog
   ```
5. Auto-refresh behavior:
   - default: iframe morphing (or full refresh depending on setting)
   - you can override morphing:
     ```js
     window.StatamicLivePreviewMorph = (from, to) => {
       // custom update
     }
     ```
6. Headless integration:
   - point preview target to your frontend preview URL (e.g. `?preview=true`)
   - Statamic appends a `token` query param; use it in GraphQL/REST to fetch draft/live-preview content.
   - For push updates without refresh: set `refresh: false` and listen for `postMessage`:
     ```js
     window.onmessage = (e) => {
       if (e.data.name === 'statamic.preview.updated') {
         // use e.data.token + e.data.reference
       }
     }
     ```
7. Custom rendering route (max control):
   - create a route that fetches the live preview item:
     ```php
     $entry = LivePreview::item($request->statamicToken());
     ```
     return your own view.

## Pitfalls / gotchas
- Headless previews require implementing token-aware fetching on the frontend.

## Sources
- https://statamic.dev/control-panel/live-preview
