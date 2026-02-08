# Advanced Topics: Task Scheduling

**Status (docs):** The Statamic 6 docs page at `/advanced-topics/task-scheduling` currently returns a 404 with navigation only (no readable content via web_fetch).

## What to do instead
- Use standard **Laravel Task Scheduling** (`app/Console/Kernel.php`) + cron running `php artisan schedule:run`.
- For Statamic-specific scheduled content, note:
  - scheduled entries trigger invalidation rules when scheduler is running (see Static Caching docs).
- If you need the Statamic docs page content:
  - open in browser and/or check Statamic docs repo.

## Sources
- https://statamic.dev/advanced-topics/task-scheduling
- https://laravel.com/docs/scheduling
