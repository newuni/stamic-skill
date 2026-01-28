# Content Modeling: Revisions

**Summary:** Revisions (Pro feature) adds a publishing workflow with states (unpublished, working copy, revision, published). When enabled, edits to published entries are stored in a working copy until you publish, letting teams iterate without pushing changes live.

**When to use:**
- Content workflows where editors need drafts/working copies and rollback.
- You want revision history and safe publishing of updates.

## Steps
1. Ensure Statamic Pro is enabled (Revisions is a Pro feature).
2. Enable revisions globally in `.env`:
   - `STATAMIC_REVISIONS_ENABLED=true`
3. Enable revisions per collection by setting `revisions: true` on the collection(s).
4. Know storage:
   - default: `storage/statamic/revisions`
   - you can move it via `config/statamic/revisions.php`, e.g.:
     ```php
     'path' => base_path('content/revisions'),
     ```
5. Understand the key states:
   - **Unpublished**: you edit the entry file directly; can save revisions.
   - **Published**: new edits go to a **working copy** until published.
   - **Revision**: saved snapshot (YAML) you can preview/restore.
6. Use history to preview/restore previous states.

## Pitfalls / gotchas
- Best practice: keep revisions **off during development** (extra steps/overhead).
- Revisions are ignored by git by default; if you want them versioned, consider moving the path rather than changing `.gitignore`.

## Sources
- https://statamic.dev/content-modeling/revisions
