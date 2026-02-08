# Addons: Commands

**Summary:** Addons can ship Artisan/“please” commands. Define your command classes (normal Laravel Artisan commands) and register them via your addon's `AddonServiceProvider` using the `$commands` property (or manual registration). Commands are great for one-off maintenance, indexing, migrations, or integrations.

**When to use:**
- You need CLI entry points for your addon (setup, sync, import/export, maintenance).

## Steps
1. Create a Laravel Artisan command class (typical `Illuminate\Console\Command`).
2. In your addon service provider (extends `Statamic\Providers\AddonServiceProvider`), register commands:
   ```php
   protected $commands = [
     \Vendor\Package\Commands\MyCommand::class,
   ];
   ```
3. Run commands like any Laravel command:
   - `php artisan your:command`
   - (Statamic also exposes many commands under `php please ...`; your addon’s commands will still be artisan commands unless you provide your own entry pattern.)
4. If you need post-install behavior, use `Statamic::afterInstalled(...)` in `bootAddon()` to call commands.

## Pitfalls / gotchas
- Keep command behavior idempotent where possible (safe to run twice).

## Sources
- https://statamic.dev/addons/building-an-addon (Registering Components + Post-install)
