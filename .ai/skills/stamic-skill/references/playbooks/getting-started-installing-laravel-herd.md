# Getting Started: Installing locally with Laravel Herd

**Summary:** Laravel Herd is the recommended, low-friction local environment for macOS/Windows. Install Herd, then install the Statamic CLI and scaffold a new project. Herd serves it at `http://your-project-name.test`.

**When to use:**
- Onboarding devs on macOS/Windows.
- You want a “just works” PHP + Composer local setup without Homebrew/Valet complexity.

## Steps
1. Install Laravel Herd from https://herd.laravel.com
2. Install the Statamic CLI:
   ```bash
   composer global require statamic/cli
   ```
3. From your Herd projects directory (often `~/Herd`), create a new site:
   ```bash
   statamic new your-project-name
   ```
4. Open the site:
   - Frontend: `http://your-project-name.test`
   - Control Panel: `/cp`

## Pitfalls / gotchas
- If `statamic` is “command not found”, fix Composer global bin path / troubleshoot your global packages.
- You can enable Pro features during dev by setting `'pro' => true` in `config/statamic/editions.php`.

## Sources
- https://statamic.dev/getting-started/installing/laravel-herd
