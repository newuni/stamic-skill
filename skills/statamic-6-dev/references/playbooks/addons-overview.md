# Addons: Overview

**Summary:** Addons are Composer packages that extend Statamic. You install them with Composer, manage licensing via the Statamic Marketplace, and (optionally) select addon editions in `config/statamic/editions.php`.

**When to use:**
- You need third-party functionality.
- You want to ship reusable Statamic features across projects.

## Steps
1. Find addons in the Statamic Marketplace.
2. Install with Composer:
   ```bash
   composer require vendor/package
   ```
   (Some first-party addons have dedicated `php please install:*` commands.)
3. For commercial addons:
   - add your site key
   - attach licenses to sites in your Statamic account
   - you can trial locally but buy before production
4. If an addon supports editions, choose edition in `config/statamic/editions.php`:
   ```php
   'addons' => [
     'vendor/package' => 'pro',
   ]
   ```

## Pitfalls / gotchas
- Edition selection is config-driven; keep it consistent across environments.

## Sources
- https://statamic.dev/addons/overview
