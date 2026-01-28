# Content Modeling: Blueprints

**Summary:** Blueprints define the fields and structure editors see in publish forms and the schema developers render on the frontend. Blueprints are YAML files under `resources/blueprints/` and can be created via the Control Panel or by creating files directly.

**When to use:**
- Defining/editing fields for entries, terms, globals, assets, forms, and users.
- Reusing field definitions across content types.

## Steps
1. Create/edit blueprints via:
   - the relevant CP area (collections/taxonomies/forms/etc.)
   - the CP Blueprints hub
   - editing YAML files under `resources/blueprints/`
2. Know the directory layout:
   - `resources/blueprints/collections/<collection>/*.yaml`
   - `resources/blueprints/taxonomies/<taxonomy>/*.yaml`
   - `resources/blueprints/globals/<set>.yaml`
   - `resources/blueprints/assets/<container>.yaml`
   - `resources/blueprints/forms/<form>.yaml`
   - users: `resources/blueprints/user.yaml`
3. Structure a blueprint with `sections`, each section becoming a tab in the publish form.
4. Use conditional fields when needed (rules documented separately).
5. Reuse fields:
   - reference fieldset fields via `field: <fieldset>.<field>`
   - override referenced fields via a `config:` block
   - import entire fieldsets with `import:` (use `prefix:` if importing multiple times)
6. Add validation rules on fields (Laravel rules + Statamic specifics).
7. For complex fieldtypes (Grid/Bard/Replicator), define sub-fields using the blueprint field syntax so you can reference/import fieldsets.

## Pitfalls / gotchas
- Blueprint fields are indexed sequentially (not keyed by handle) to enable reuse/overrides/import patterns.
- If you override entry fields via nav items or other contexts, ensure fieldtype compatibility.

## Sources
- https://statamic.dev/content-modeling/blueprints
