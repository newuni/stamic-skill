# Getting Started: Installing Statamic (overview)

**Summary:** Statamic is self-hosted, so installation can be done in multiple ways (local/CLI, into an existing Laravel app, Docker, or various hosts). Choose the path that matches your workflow; for most dev teams, local installs via the Statamic CLI (and optionally Laravel Herd) are the smoothest.

**When to use:**
- Deciding “which install path should we use?”
- Pointing teammates to the right install guide for their OS/workflow.

## Steps
1. Choose an install path:
   - **Laravel Herd** (macOS/Windows) for fast local setup.
   - **Statamic CLI** (macOS/Windows/Linux) for a standard Statamic project.
   - **Install into existing Laravel** if you need Statamic inside an existing app.
   - **Docker** if your team standardizes on containers.
   - **Cloud/host-specific** if you’re starting from infra constraints.
2. Follow the corresponding guide and keep the result reproducible (document in your project notes).

## Pitfalls / gotchas
- Installing into an existing Laravel app is valid, but you’ll often need to set up “starter” content/views manually (pages collection, default layout/template assumptions).

## Sources
- https://statamic.dev/getting-started/installing
