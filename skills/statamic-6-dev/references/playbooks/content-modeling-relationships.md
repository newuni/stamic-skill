# Content Modeling: Relationships

**Summary:** Relationships in Statamic are stored as IDs/handles in fields, and (when you use relationship fieldtypes in blueprints) they’re automatically resolved/augmented so you can work with related objects directly in templates (entries, terms, users, assets, etc.).

**When to use:**
- You need “related content” (author, related posts, product category/brand, etc.).
- You want to render linked assets/users/entries without writing manual queries.

## Steps
1. Model the relationship using the right fieldtype in your blueprint (examples include Assets, Entries, Taxonomies/Terms, Users, etc.).
2. Store references (IDs/handles/paths) in the entry’s data (front matter) via the publish form or file editing.
3. Render related objects in templates directly (thanks to augmentation), e.g.:
   - `{{ author:name }}` for a related user
   - `{{ photo:url }}` for a related asset
   - loop an entries relationship: `{{ related_products }} ... {{ /related_products }}`
4. If you only have an ID/handle and no relationship fieldtype, fetch manually using `get_content`:
   ```antlers
   {{ get_content from="123-..." }}
     <a href="{{ url }}">{{ title }}</a>
   {{ /get_content }}
   ```
   or pass a variable: `{{ get_content :from="related_id" }}`

## Pitfalls / gotchas
- Augmentation/resolution is easiest when the field is defined in a blueprint using a relationship fieldtype.

## Sources
- https://statamic.dev/content-modeling/relationships
