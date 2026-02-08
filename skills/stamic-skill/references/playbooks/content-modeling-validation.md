# Content Modeling: Validation

**Summary:** Statamic uses Laravel’s validation system for field validation, configured per field in blueprints/fieldsets. It supports all Laravel rules plus Statamic-specific uniqueness rules for entries/terms/users, and has patterns for validating nested fields (Grid/Replicator/Bard).

**When to use:**
- Enforcing required fields and data integrity on publish forms.
- Validating nested/conditional data.
- Validating in custom code before saving.

## Steps
1. Add validation on a field via the Validation tab in the blueprint/fieldset (or YAML `validate:`).
2. For required fields, use the shortcut toggle or `required: true`.
3. For nested fields (Grid/Replicator/Bard), validate sub-fields normally.
4. When a nested rule needs to reference another field in the *same* nested context, use `{this}`:
   - example: `required_with:{this}.purchasable`
5. Prefer conditional fields + `sometimes|required` when it improves clarity over `{this}`.
6. Use Statamic uniqueness rules when you need uniqueness across entries/terms/users:
   - `UniqueEntryValue({collection}, {id}, {site})`
   - `UniqueTermValue({taxonomy}, {id}, {site})`
   - `UniqueUserValue({id})` (optionally specify field)
7. Use Laravel Rule objects for custom rules (escape quotes correctly in YAML).
8. Programmatic validation pattern:
   ```php
   $values = $request->all();
   $valid = $blueprint->fields()->addValues($values)->validate();
   $entry->data($valid)->save();
   ```

## Pitfalls / gotchas
- When writing Rule objects directly in YAML, you may need to escape quotes.

## Sources
- https://statamic.dev/content-modeling/validation
