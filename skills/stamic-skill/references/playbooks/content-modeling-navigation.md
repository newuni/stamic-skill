# Content Modeling: Navigation

**Summary:** Navs are hierarchical link trees (a structure) used to render menus. Items can reference entries, hardcoded URLs, or plain text nodes. Nav configuration and the tree data are stored as YAML files.

**When to use:**
- Building site menus (header/footer) that editors can manage.
- You need a tree that isn’t strictly the same as a pages collection’s structure.

## Steps
1. Create a nav (e.g. `header`, `footer`) and configure allowed collections for entry references.
2. Understand storage:
   - nav config: `content/navigation/<handle>.yaml`
   - tree data: `content/trees/navigation/<handle>.yaml`
3. Render in templates using the `nav` tag:
   ```antlers
   <ul>
     {{ nav:footer }}
       <li><a href="{{ url }}">{{ title }}</a></li>
     {{ /nav:footer }}
   </ul>
   ```
4. If you need more fields on nav items (icons, excerpts, etc.), add fields to the nav blueprint.
   - Those values are stored under a `data:` key on the tree nodes.
5. For entry-reference items: understand override behavior.
   - Fields on the nav item can override fields from the referenced entry.
   - If you plan to override entry fields, keep fieldtypes consistent (reusable fields can help).

## Pitfalls / gotchas
- Entry references use the entry’s own URL (defined by the collection), regardless of where the entry sits inside the nav tree.
- Multi-site can have different trees per nav.

## Sources
- https://statamic.dev/content-modeling/navigation
