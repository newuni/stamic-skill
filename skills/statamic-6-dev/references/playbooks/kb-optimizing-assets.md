# Knowledge Base: Optimizing Assets

**Summary:** Asset containers can point to local disks or remote storage (S3/Spaces). Remote disks can be slow due to many file operations/API calls. Improve performance by reducing per-request filesystem checks and caching filesystem metadata.

**When to use:**
- Slow asset browsing in CP.
- Many assets on S3/remote storage.

## Steps
1. Disable the Stache watcher on production:
   ```php
   // config/statamic/stache.php
   'watcher' => false,
   ```
   (Then rely on CP edits or manual cache clears after file changes.)
2. Consider Flysystem caching (legacy note):
   - `league/flysystem-cached-adapter` only works with older stacks (Laravel <= 8 / Flysystem v1).
   - If you’re on modern Laravel/Flysystem, prefer other approaches (CDNs, fewer calls, app-level caching).
3. Disable Flysystem asserts for remote disks:
   ```php
   // config/filesystems.php
   'disable_asserts' => true,
   ```
   This avoids an extra “exists?” check before reads.
4. For addon code: check existence via Asset objects (memoizes calls):
   ```php
   $asset = AssetContainer::find('s3')->makeAsset('foo.jpg');
   $asset->exists();
   ```
   Avoid repeated `$asset->disk()->exists(...)` / `File::exists(...)` in tight loops.

## Pitfalls / gotchas
- Disabling watcher means manual file edits won’t be picked up automatically without cache refresh.

## Sources
- https://statamic.dev/knowledge-base/tips/optimizing-assets
