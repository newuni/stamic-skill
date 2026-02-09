# Backend & APIs: Progress

**Summary:** The Progress page is currently a placeholder in Statamic 6 docs. For real-world implementations, track long-running work with queues plus user feedback patterns (toasts, polling, dashboard state) using documented CP extension tools.

**When to use:**
- You are implementing long-running tasks in addons or CP tools.
- You need operational status feedback without relying on undocumented APIs.

## Steps
1. Move heavy work to queued jobs.
2. Surface progress/result state through CP UI patterns (toasts, utility pages, polling).
3. Store job state in an explicit model/cache key if users need to refresh/reopen the page.
4. Handle completion/failure with clear user-facing messages.

## Pitfalls / gotchas
- Running long tasks synchronously in CP requests leads to timeouts and poor UX.
- Implicit progress assumptions are fragile; persist explicit state when needed.

## Sources
- https://statamic.dev/backend-apis/progress
