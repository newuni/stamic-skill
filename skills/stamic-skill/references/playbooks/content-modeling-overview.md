# Content Modeling: Overview

**Summary:** Decide the “shape” of content before building templates/features. In Statamic, content modeling is primarily: collections (content types), blueprints/fields (structure), relationships (reuse), and globals (site-wide shared content). Separate content from presentation to keep content reusable when designs change.

**When to use:**
- Starting a new project or redesign.
- The team is about to create lots of page-specific fields.
- You need a shared language for modeling content cleanly.

## Steps
1. Separate content from presentation: don’t encode layout decisions into the content model.
2. Start by listing content types → model them as **collections** (Articles, News, Case Studies, Pages, etc.).
3. Watch for reusable “entities” (e.g., Features) that deserve their own collection and are referenced via relationship fields.
4. Define fields via **blueprints**.
5. Extract repeated field groups into **fieldsets** and import them where needed.
6. Use **globals** for site-wide shared content (footer links, social profiles, global CTAs).
7. Avoid these traps:
   - modeling pages instead of content (fields like `left_column_text`)
   - over-modeling everything (too many fields for one-off content)
   - assuming today’s structure won’t change

## Pitfalls / gotchas
- Page-layout-shaped fields become painful when you redesign or want reuse.

## Sources
- https://statamic.dev/content-modeling/overview
