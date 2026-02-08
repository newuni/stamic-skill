# Frontend: Image Manipulation (Glide)

**Summary:** Statamic uses Glide for image resizing/cropping/effects. Configure route, presets, driver (gd/imagick/libvips), and caching strategy. Use the Glide tag to generate manipulated images.

**When to use:**
- Responsive images/thumbnails/hero crops.
- Performance tuning for image generation (dynamic vs static vs CDN).

## Steps
1. Configure image manipulation in `config/statamic/assets.php`:
   - route (default `/img/...`)
   - presets (named parameter sets)
   - driver (`gd`, `imagick`, or custom)
2. Use presets via the Glide tag:
   - `preset="thumbnail"` etc.
3. Preset generation:
   - generated on upload by default
   - disable with `generate_presets_on_upload: false`
   - generate manually: `php please assets:generate-presets`
4. (Optional) Process source images on upload with a dedicated preset (use `fit: max` to avoid upscaling).
5. Configure caching strategy:
   - dynamic (default, cache=false) served via route; faster page render, slower first image hit
   - static path (`cache=true` + `cache_path` under public) generates files eagerly
   - CDN disk (`cache='glide'` and configure a filesystem disk)
6. If using CDN disk, configure path cache store (`stores.glide` in `config/cache.php`) to avoid expensive “exists” checks.
7. Clear Glide cache: `php please glide:clear`

## Pitfalls / gotchas
- Don’t use the same disk/bucket/url for source images and Glide cache; clearing Glide cache could wipe your originals.
- For dynamic mode, consider disabling Stache watcher (`STATAMIC_STACHE_WATCHER=false`) as suggested in docs.

## Sources
- https://statamic.dev/frontend/image-manipulation
