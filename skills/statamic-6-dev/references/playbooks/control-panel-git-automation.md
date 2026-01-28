# Control Panel: Git Automation

**Summary:** Statamic can automatically (or manually) commit and push content/config changes to a Git repo when authors save content. Configure tracked paths, auto-commit behavior, push, queues/delays, scheduled commits, and commit message customization.

**When to use:**
- Git-based content workflow (content stored in repo).
- You want CP edits to produce commits automatically.

## Steps
1. Enable Git automation (per environment):
   ```env
   STATAMIC_GIT_ENABLED=true
   ```
2. Configure in `config/statamic/git.php`:
   - git user identity:
     - default uses authenticated user
     - set `use_authenticated=false` to always use configured user.
   - tracked paths (defaults cover common content locations).
3. Automatic committing:
   - enable/disable:
     ```env
     STATAMIC_GIT_AUTOMATIC=false
     ```
   - manual commit via CLI:
     ```bash
     php please git:commit
     ```
4. Pushing commits:
   ```env
   STATAMIC_GIT_PUSH=true
   ```
   Ensure server has:
   - git remote
   - upstream branch
   - SSH auth to push.
5. Queueing for performance:
   - commits are queued when automatic is enabled
   - use a real queue for performance:
     ```env
     STATAMIC_GIT_QUEUE_CONNECTION=redis
     ```
6. Delaying commits:
   - `dispatch_delay` (minutes) to consolidate bursts; requires non-sync queue.
7. Scheduling commits:
   - disable `automatic`, then schedule:
     ```php
     Schedule::command('statamic:git:commit')->everyTenMinutes();
     ```
     Ensure scheduler cron runs.
8. Avoid circular deployments:
   - append `[BOT]` in commit message in `commands` and cancel deploys when message contains `[BOT]`.
9. Ignore noisy events (e.g. users in DB):
   - add event classes to `ignored_events` and remove related tracked paths if needed.
10. Addon developers:
   - register addon events with the git listener:
     ```php
     Git::listen(PunSaved::class);
     ```
   - optionally implement `ProvidesCommitMessage`.

## Pitfalls / gotchas
- In background queue/scheduler contexts, there’s no authenticated user; configure fallback git user.

## Sources
- https://statamic.dev/control-panel/git-automation
