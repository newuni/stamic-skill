# Frontend: Assets

**Summary:** Assets are files (images/videos/PDFs/etc.) managed via containers (local/S3/etc.). Statamic caches asset metadata in `.meta` YAML files and exposes assets on the frontend via fieldtypes and tags, with optional image manipulation via Glide.

**When to use:**
- Building image galleries/downloads/media components.
- Debugging asset URLs/visibility/metadata.
- Choosing between selecting assets (fieldtype) vs listing assets (tag).

## Steps
1. Define/configure asset containers (typically in CP) and understand storage:
   - container config: `content/assets/<handle>.yaml`
   - disk config: `config/filesystems.php`
2. Understand metadata:
   - `.meta/<file>.yaml` caches dimensions, filesize, etc.
   - may also store author-entered data (alt, focus, etc.) via the container blueprint
   - consider version-controlling `.meta` if alt/focal points matter
3. Choose frontend usage pattern:
   - **Assets fieldtype**: editors select assets on entries/terms/globals/users; templates loop through Asset objects.
   - **Assets tag**: list assets from a container/folder without manual selection.
4. Image transforms:
   - use Glide tag for resizing/cropping/filters.
5. Private containers:
   - place outside webroot
   - omit disk `url` and set visibility to private
6. Security/perms:
   - uploads restricted by extension; add to `config/statamic/assets.php` as needed
   - SVGs are sanitized on upload (configurable)
7. Caching:
   - consider custom cache stores for asset metadata/folder listing if `php artisan cache:clear` is disruptive
   - clear asset caches via `php please assets:clear-cache`

## Pitfalls / gotchas
- If a disk has no `url`, Statamic won’t output URLs.
- Leaving a “private” disk under webroot still exposes files directly.

## Sources
- https://statamic.dev/frontend/assets
