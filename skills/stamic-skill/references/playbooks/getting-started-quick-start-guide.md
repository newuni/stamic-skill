# Getting Started: Quick Start Guide

**Summary:** A guided walkthrough that connects the key building blocks: templates/layouts/partials, collections + routes, entries, and blueprints/fields. The fastest way to internalize “how it all fits together”.

**When to use:**
- First Statamic project.
- You have a static HTML concept and want to “Statamic-ify” it.
- You need a canonical example of collections + routing + templates + partials.

## Steps (high-level)
1. Create a new Statamic site using the Statamic CLI.
2. Create (or ensure) a super user and sign into `/cp`.
3. Create/edit your homepage entry and render its fields in `resources/views/home.antlers.html`.
4. Understand layout vs template:
   - layout holds global HTML wrapper
   - templates render per-page content via `{{ template_content }}` in the layout
5. Create a Blog collection:
   - scaffold index/show views
   - configure routing rule (URL pattern)
   - (optionally) enable publish dates
6. Render a list of recent posts on the homepage using the `collection` tag.
7. Refactor repeated markup into a partial (e.g. blog listing) and pass parameters (e.g. `limit`) and slots.
8. Add basic site navigation using the `nav` tag for an ordered Pages collection.

## Pitfalls / gotchas
- Keep routing patterns simple at first; you can change them later.
- Remember: when you’re on an entry URL, entry fields are typically available directly without needing a `collection:*` fetch.
- Don’t cargo-cult the styling; the guide uses Tailwind to make the example clearer.

## Sources
- https://statamic.dev/getting-started/quick-start-guide
