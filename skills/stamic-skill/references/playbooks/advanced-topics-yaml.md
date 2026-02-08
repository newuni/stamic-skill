# Advanced Topics: YAML

**Summary:** YAML is a human-readable data format used heavily by Statamic for settings and content (including “front matter” blocks). It’s JSON-compatible and supports scalars (strings, numbers, bool, null) plus sequences (lists) and mappings (objects).

**When to use:**
- Editing Statamic config/content files.
- Understanding how blueprint-driven content is stored.

## Steps
1. Basic mapping:
   ```yaml
   title: Hello
   published: true
   count: 12
   nothing: null
   ```
2. Quote strings when punctuation would confuse parsing:
   ```yaml
   cartoon: "Rocko's Modern Life"
   ```
3. Multiline strings:
   - preserve newlines with `|`:
     ```yaml
     body: |
       Line 1
       Line 2
     ```
   - fold newlines with `>`:
     ```yaml
     body: >
       These lines
       become one paragraph.
     ```
4. Lists (sequences):
   ```yaml
   tags:
     - one
     - two
   ```
   or inline:
   ```yaml
   tags: [one, two]
   ```
5. Nested structures (common in Bard/Grid/Replicator):
   ```yaml
   students:
     - name: Zach
       school: Bayside High
     - name: Jack
       school: Flatside High
   ```
6. Explicit typing / disambiguation when needed:
   ```yaml
   value_as_string: "10"
   yes_string: !!str Yes
   ```

## Pitfalls / gotchas
- Indentation matters; YAML convention is **2 spaces**.
- Unquoted values like `Yes`/`No` can be surprising; quote or cast when in doubt.

## Sources
- https://statamic.dev/advanced-topics/yaml
- https://symfony.com/doc/current/components/yaml.html
