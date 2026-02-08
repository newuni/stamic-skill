# Control Panel: Dashboard

**Summary:** The dashboard is a configurable screen composed of widgets. Configure it to surface the things your team needs (recent entries, drafts/scheduled content, submissions, updates, shortcuts).

**When to use:**
- Team wants a “control center” after login.
- You need custom widgets or a curated default dashboard.

## Steps
1. Add widgets via `config/statamic/cp.php` in the `widgets` array.
2. Use built-in widgets where possible; create custom widgets only when needed.
3. Configure widget instances by `type` and widget-specific settings.
4. Set widget widths (25/33/50/66/75/100).
5. Repeat widgets with different configs if useful.

## Pitfalls / gotchas
- Dashboard config is code-level; user-specific tweaks may still exist depending on setup.

## Sources
- https://statamic.dev/control-panel/dashboard
