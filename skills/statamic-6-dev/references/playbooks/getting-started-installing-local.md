# Getting Started: Installing locally (Statamic CLI)

**Summary:** The recommended dev workflow is to build locally and deploy via version control. Use the Statamic CLI to scaffold a new project quickly, then serve it via your preferred local server (Herd/Valet) or `php artisan serve`.

**When to use:**
- Starting a new Statamic project from scratch.
- Standardizing onboarding steps for dev machines.

## Steps
1. Ensure prerequisites: supported PHP, Composer (and a local server approach).
2. Install the Statamic CLI globally:
   ```bash
   composer global require statamic/cli
   ```
3. Create a new site:
   ```bash
   statamic new project_name
   ```
   - Choose blank vs Starter Kit.
   - Create your first super admin user.
4. Access the site:
   - With Valet/Herd: `http://project_name.test` and Control Panel at `/cp`.
   - Without a local server: run:
     ```bash
     php artisan serve
     ```
     then open the URL it prints.
5. If something fails, use the docs troubleshooting section rather than random searching.

## Pitfalls / gotchas
- Your local URL differs depending on your local tooling (Valet/Herd vs artisan serve).
- If you use Tailwind (default installs / first-party Starter Kits), remember to run `npm install` and `npm run dev` while developing.

## Sources
- https://statamic.dev/getting-started/installing/local
