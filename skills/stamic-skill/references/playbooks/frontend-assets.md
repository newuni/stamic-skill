# Frontend: Assets

**Summary:** Assets are files (images, PDFs, etc.) managed via asset containers (local disk or remote like S3). Statamic caches asset metadata in `.meta/*.yaml` files and can attach blueprint fields (alt text, focal point, etc.) to assets.

**When to use:**
- Implementing image galleries/downloads.
- Managing metadata like alt/focus.
- Performance tuning for large/remote asset stores.

## Steps
1. Define asset containers (CP) → stored as YAML under `content/assets/*.yaml`.
2. Configure the underlying Laravel filesystem disk in `config/filesystems.php`.
3. Understand metadata storage:
   - `.meta/<asset>.yaml` stores cached + user data.
   - consider version controlling `.meta` if you care about alt/focus.
4. Private containers:
   - locate disk root outside webroot
   - omit `url` on disk to avoid direct URLs
   - set visibility to `private`.
5. Use on the frontend:
   - **Assets fieldtype** (selected assets on entries):
     ```antlers
     {{ slideshow }}<img src="{{ url }}" alt="{{ alt }}">{{ /slideshow }}
     ```
   - **Assets tag** (query assets in a container/folder):
     `{{ assets container="photos" limit="10" }}`
6. Image manipulation:
   - use Glide / `glide` tag (see image manipulation playbook).
7. Upload security:
   - allow extra extensions in `config/statamic/assets.php` (`additional_uploadable_extensions`).
   - SVGs are sanitized by default; can disable if you trust users.
8. Cache stores:
   - optionally configure `asset_meta` and `asset_container_contents` cache stores in `config/cache.php`.
   - clear via `php please assets:clear-cache`.

## Pitfalls / gotchas
- Putting “private” assets inside webroot still makes them accessible if URL is known.

## Sources
- https://statamic.dev/frontend/assets
