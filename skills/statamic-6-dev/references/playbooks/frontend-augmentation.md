# Frontend: Augmentation

**Summary:** Augmentation lazily transforms Blueprint-defined values into their “usable” forms based on fieldtype (e.g. Markdown → HTML, entries IDs → Entry objects). Antlers and the APIs rely heavily on augmentation.

**When to use:**
- Understanding why a value appears transformed in templates/API.
- Building custom augmentables / custom data objects.

## Key ideas
- Only **Blueprint-defined fields** are augmented. Front matter “ad-hoc” variables are not.
- Augmentation is lazy: values are only converted when needed.

## Steps
1. Recognize augmentation in templates:
   - Markdown fieldtype outputs HTML automatically.
2. Know the two augmentable things:
   - **Value objects** (field value + fieldtype)
   - **Augmentable objects** (Entry/Asset/User/etc.)
3. Access raw vs augmented values in PHP:
   ```php
   $value->raw();   // stored
   $value->value(); // augmented
   ```
4. In REST API, responses are augmented; selecting `fields=` avoids computing unused augmented keys.
5. Build custom augmentables:
   - implement `Statamic\Contracts\Data\Augmentable`
   - use `HasAugmentedData` (simple) or `HasAugmentedInstance` (advanced)
6. Shallow augmentation exists to avoid massive nested payloads and infinite loops.

## Pitfalls / gotchas
- Nested/related items are shallow-augmented by default; override shallow keys only if you must.

## Sources
- https://statamic.dev/frontend/augmentation
