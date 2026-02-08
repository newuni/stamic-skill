# Content Modeling: Globals

**Summary:** Globals are site-wide variables available in all views. Organize them into global sets (scopes) like `footer`, store them in `content/globals/`, and optionally add a blueprint when you need fieldtypes/control/GraphQL.

**When to use:**
- Shared content used across the site (footer, header, social links, settings toggles).
- Site-level configuration content editors need to change.

## Steps
1. Create a global set (e.g. `footer`, `global`).
2. Understand storage:
   - set metadata: `content/globals/<handle>.yaml`
   - per-site values: `content/globals/<site>/<handle>.yaml`
3. Render globals in templates:
   - scoped: `{{ footer:copyright }}`
   - if you have one default global set, scope can be optional (e.g. `{{ global:var }}` or `{{ var }}` depending on setup)
4. Add a blueprint when needed:
   - create/configure via Control Panel
   - stored at `resources/blueprints/globals/<handle>.yaml`

## Pitfalls / gotchas
- Without a blueprint, keys in the YAML are treated as text variables; add a blueprint when you need specific fieldtypes or GraphQL.
- Multi-site: globals can differ per site; keep that in mind when testing.

## Sources
- https://statamic.dev/content-modeling/globals
