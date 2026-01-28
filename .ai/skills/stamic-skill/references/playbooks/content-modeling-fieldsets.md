# Content Modeling: Fieldsets

**Summary:** Fieldsets are reusable field definitions that you can reference or import into blueprints (and into certain complex fieldtypes like Grid/Replicator/Bard). Unlike blueprints, fieldsets aren’t attached directly to content.

**When to use:**
- You want DRY, consistent fields across many blueprints.
- You want to reuse the same “block” of fields in multiple places.

## Steps
1. Create a fieldset via the Control Panel (Fieldsets area) or by creating YAML in `resources/fieldsets/`.
2. Define fields (fieldsets contain fields only; no sections/tabs).
3. Organize fieldsets with subdirectories by using `.` in the handle to indicate nesting.
4. Use fieldsets from the blueprint side:
   - reference a field: `field: <fieldset>.<field>`
   - import a full fieldset via `import:` (see blueprint reusable fields patterns)
5. Reuse inside complex fieldtypes when needed (Grid/Replicator/Bard) using the blueprint field syntax.

## Pitfalls / gotchas
- Fieldsets don’t attach to content directly; they only become active when referenced/imported into a blueprint.

## Sources
- https://statamic.dev/content-modeling/fieldsets
- Related: https://statamic.dev/content-modeling/blueprints#reusable-fields
