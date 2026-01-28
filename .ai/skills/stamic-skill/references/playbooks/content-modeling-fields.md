# Content Modeling: Fields

**Summary:** Fields are the UI + storage units for content in the Control Panel. Fields live in blueprints/fieldsets, have common settings (display/handle/instructions/listable/etc.), have data-flow rules when hidden/computed, and are “augmented” into richer objects for frontend usage.

**When to use:**
- Adding or debugging a field in a blueprint.
- Understanding why a field isn’t saving (visibility/data-flow).
- Understanding why a value behaves differently in templates (augmentation).

## Steps
1. Configure the universal field settings:
   - Display, Handle, Instructions
   - Listable/Sortable
   - Visibility
   - Always Save
   - Localizable
2. Choose field visibility correctly:
   - Visible
   - Read Only
   - Computed (shows computed value; never submits on save)
   - Hidden (hidden but still submits current value on save)
3. Understand field data flow:
   - Dynamically hidden fields (via conditional fields) generally won’t submit on save.
   - Override that with a Revealer fieldtype or by enabling “Always Save”.
4. Place fields in **blueprints** (publish forms) and **fieldsets** (reusable definitions).
5. Use the right **fieldtype** for the authoring experience and storage format.
6. Rely on **augmentation** in templates:
   - Assets fields → Asset objects
   - Relationship fields → related content objects
   - Markdown fields → parsed HTML
   (Augmentation happens when a field is defined in a blueprint.)
7. For multi-site, mark fields as localizable when they should differ per site.
8. For UI translations, provide translation strings via Laravel localization (JSON or lang files).

## Pitfalls / gotchas
- Data created “on the fly” in front matter may not be augmented; you may need modifiers.
- Conditional hiding can prevent saving; use Revealer/Always Save when necessary.

## Sources
- https://statamic.dev/content-modeling/fields
