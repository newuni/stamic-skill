# Advanced Topics: Task Scheduling

**Summary:** Statamic leverages Laravel’s Task Scheduler. Run a single cron entry every minute calling `php artisan schedule:run`, and define your own scheduled tasks in `routes/console.php` (or app kernel as per Laravel).

**When to use:**
- Scheduled publishing behavior and scheduled entry processing.
- Any recurring tasks (syncs, warmers, cleanup) without relying on web traffic.

## Steps
1. Production cron (once per minute):
   ```cron
   * * * * * cd /path-to-your-project && php artisan schedule:run >> /dev/null 2>&1
   ```
2. Local development:
   ```bash
   php artisan schedule:work
   ```
3. Built-in Statamic scheduled behavior:
   - Statamic dispatches `Statamic\Events\EntryScheduleReached` when scheduled entries hit their time (used for things like search index updates and cache invalidation).
4. Define your own schedules (example in `routes/console.php`):
   ```php
   Schedule::command('my-command')->daily();
   Schedule::job(new Heartbeat)->everyFiveMinutes();
   ```

## Pitfalls / gotchas
- If the scheduler isn’t running, scheduled-entry side effects won’t happen “on time”.

## Sources
- https://statamic.dev/advanced-topics/scheduling
- https://laravel.com/docs/scheduling
