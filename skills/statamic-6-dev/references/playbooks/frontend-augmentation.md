# Frontend: Augmentation

**Summary:** Augmentation lazily transforms blueprint-defined field values based on fieldtype (e.g. Markdown → HTML, entries IDs → Entry objects). It happens primarily in Antlers templates and the REST API. Values defined “on the fly” in front matter are not augmented.

**When to use:**
- You’re surprised by what a variable outputs (raw vs augmented).
- You need to understand performance implications (lazy evaluation).
- You’re building custom data classes / APIs.

## Steps
1. Remember the rule: **only blueprint-defined fields are augmented**.
2. Use fieldtypes that augment into richer data (entries/assets/relationships) so templates are simpler.
3. Understand the two augmentable things:
   - **Value** objects (field value + fieldtype) → `value()` vs `raw()`
   - **Augmentable** objects (Entry/Asset/User/etc.) → `toAugmentedArray` / augmented instances
4. For REST API responses, use field filtering to avoid computing expensive augmented values.
5. For performance-sensitive computed augmented values, design them to be lazy and cache where appropriate.
6. Understand shallow augmentation to avoid huge nested payloads and infinite loops.

## Pitfalls / gotchas
- Front matter variables created outside a blueprint won’t be augmented; you may need modifiers.
- Computation happens when the value is used; a template that never references a value won’t pay the cost.

## Sources
- https://statamic.dev/frontend/augmentation
