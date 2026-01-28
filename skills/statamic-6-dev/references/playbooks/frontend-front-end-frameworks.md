# Frontend: Front-End Frameworks (JavaScript Frameworks)

**Summary:** When using a JS framework (Vue/React/etc) with Statamic, you can either *hydrate* components with JSON rendered server-side (Antlers/Blade) or fetch content client-side via Statamic’s Content API. Choose based on how much data you want exposed, how reusable the component is, and whether you need dynamic client-side navigation.

**When to use:**
- You’re building interactive components inside an otherwise server-rendered Statamic site.
- You need to pass entry/nav/footer data into Vue/React components.

## Steps
1. Decide your data strategy:
   - **Hydrate with JSON in the HTML** (fast, simple, good for per-page components).
   - **Fetch via API** (good for SPAs and dynamic components).
2. Hydrate a component with *all* page data (simple, but exposes everything):
   - Antlers example (conceptual): pass `page` (or other scope) through `to_json` and escape entities.
3. Prefer “selective JSON” for one-off props:
   - Build a small JSON-like structure in Antlers/Blade and pass it as a prop.
   - Good for things like nav arrays, hero blocks, feature lists.
4. Pass entry/collection data into a component:
   - Query an entry (e.g. footer entry) and JSON-encode it for a prop.
   - Use this for any entry-based data, not just the current page.
5. Fetch via the Content REST API when client-side loading makes sense:
   - Example endpoint pattern:
     - `GET /api/collections/{collection}/entries/{slug-or-id}`
   - Fetch on mount/created, store result in component state, then render.
6. For strict control over what gets exposed, consider **View Models**:
   - Build a view model to return only the fields your JS component needs.

## Pitfalls / gotchas
- **Data exposure:** “dump everything to JSON” can leak fields you didn’t intend (SEO fields, internal notes, etc).
- **Encoding/escaping:** when inlining JSON in HTML attributes, ensure proper escaping (Statamic shows `to_json | entities` pattern).
- **Live Preview limitation:** Live Preview only has the current page’s data available; collection queries for other entries won’t work there.

## Sources
- https://statamic.dev/frontend/javascript-frameworks
- https://statamic.dev/frontend/rest-api
- https://statamic.dev/frontend/view-models
- https://statamic.dev/control-panel/live-preview
