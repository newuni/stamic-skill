# Getting Started: Configuration

**Summary:** Statamic configuration is standard Laravel configuration + environment variables. Statamic-specific config lives in `config/statamic/*`. Use `.env` for environment-specific values, but never commit it, and never run debug mode in production.

**When to use:**
- You need to find “where is this setting configured?” in a Statamic project.
- You need different behavior between local/staging/prod.

## Steps
1. Look for Statamic config files in `config/statamic/` (grouped by responsibility: `system.php`, `stache.php`, `static_caching.php`, etc.).
2. Use environment variables in `.env` when settings must differ by environment.
3. Remember `.env` values are strings; use reserved values (`true`, `false`, `null`, `empty`) or quote strings with spaces.
4. Read env vars in config with `env('NAME', default)`.
5. Access config:
   - in templates via the `config` tag, e.g. `{{ config:app:awesome }}`
   - in PHP via `config('app.awesome')`
6. Keep production safe:
   - do **not** enable Debug Mode / DebugBar in production.
   - do **not** commit `.env`.
   - consider adding keys to `debug_blacklist` in `config/app.php`.

## Pitfalls / gotchas
- Debug pages can expose environment variables when `APP_DEBUG=true`; blacklist sensitive keys.

## Sources
- https://statamic.dev/getting-started/configuration
