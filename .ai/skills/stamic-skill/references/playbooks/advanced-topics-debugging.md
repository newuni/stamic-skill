# Advanced Topics: Debugging

**Summary:** Statamic debugging is Laravel debugging + a few Statamic niceties: Ignition error screens, fake SQL queries (for file-backed query builders), Debugbar/Telescope support, Antlers `dump` modifier, and standard Laravel logs.

**When to use:**
- Investigating exceptions, slow requests, “why is this variable X?”

## Steps
1. Enable Ignition error pages:
   - set `APP_DEBUG=true` in `.env`.
2. Debug bar (optional):
   ```bash
   composer require --dev barryvdh/laravel-debugbar
   ```
   Then in `.env`:
   ```env
   APP_DEBUG=true
   DEBUGBAR_ENABLED=true
   ```
3. Benchmark page performance:
   - use Debugbar Timeline tab to spot slow operations/tags.
4. Inspect variables:
   - Debugbar Variables tab shows Blueprint-defined values as `Value` objects (raw + augmented).
5. Antlers quick inspection:
   - use `dump` modifier:
     ```antlers
     {{ my_var | dump }}
     ```
6. Logs:
   - check `storage/logs/*.log`.
   - optionally show logs in Debugbar by publishing config and enabling `logs` collector:
     ```bash
     php artisan vendor:publish --provider="Barryvdh\\Debugbar\\ServiceProvider"
     ```
7. If fake SQL noise is undesirable, disable fake queries:
   - `config/statamic/system.php`:
     ```php
     'fake_sql_queries' => false,
     ```
8. For deeper Laravel debugging, use Laravel Telescope.

## Pitfalls / gotchas
- Debugbar injects JS + adds significant overhead; disable when measuring real performance.

## Sources
- https://statamic.dev/advanced-topics/debugging
