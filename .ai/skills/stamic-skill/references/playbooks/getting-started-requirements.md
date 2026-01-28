# Getting Started: Requirements

**Summary:** Statamic runs as a Laravel package, so it shares Laravel’s server requirements. Make sure your environment meets the PHP/extensions baseline and that you have image processing available (GD or ImageMagick) before you start.

**When to use:**
- Setting up a new Statamic 6 project locally or on a server.
- Debugging install/runtime issues that smell like missing PHP extensions, Composer, or image libs.

## Steps
1. Ensure your PHP version meets the minimum (Statamic docs list **PHP 8.2+**).
2. Ensure required PHP extensions are installed (BCMath, Ctype, Exif, JSON, Mbstring, OpenSSL, PDO, Tokenizer, XML).
3. Install/enable **GD** or **ImageMagick** for image manipulation.
4. Ensure **Composer** is installed and available on PATH.
5. Pick a dev environment:
   - macOS/Windows: consider **Laravel Herd**.
   - Linux: install `php`, `composer`, `npm` (plus your web server / local serving approach).

## Pitfalls / gotchas
- Missing GD/ImageMagick often only shows up when you start manipulating images (Glide, transforms).
- If you follow a “local install” guide, your actual site URL depends on your local server tool (Valet/Herd vs `php artisan serve`).

## Sources
- https://statamic.dev/getting-started/requirements
