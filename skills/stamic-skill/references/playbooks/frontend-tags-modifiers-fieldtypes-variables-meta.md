# Tags / Modifiers / Fieldtypes / Variables — meta playbook (Statamic 6)

This playbook intentionally covers **hundreds of reference pages** (tags/modifiers/fieldtypes/variables) without creating one playbook per item.

Goal: give you a repeatable workflow to:
- find the right tag/modifier/fieldtype/variable
- confirm params + scope quickly (official docs)
- debug when output isn’t what you expect

---

## Canonical roots (official docs)

Start from these “root” pages and then jump to the concrete item page.

- **Tags**
  - Overview: https://statamic.dev/tags/overview
  - All tags: https://statamic.dev/tags/all-tags

- **Modifiers**
  - Overview: https://statamic.dev/modifiers/overview
  - All modifiers: https://statamic.dev/modifiers/all-modifiers

- **Fieldtypes**
  - Overview: https://statamic.dev/fieldtypes/overview
  - All fieldtypes: https://statamic.dev/fieldtypes/all-fieldtypes

- **Variables**
  - All variables: https://statamic.dev/variables/all-variables

Citations for debugging/caching context:
- Debugging: https://statamic.dev/advanced-topics/debugging
- Caching: https://statamic.dev/advanced-topics/caching
- Stache: https://statamic.dev/advanced-topics/stache

---

## Workflow (do this every time)

1) **Identify what you need**
   - “I need to loop entries” → likely a *tag* (e.g. collection/entries-related)
   - “I need to transform a value” → likely a *modifier*
   - “I need an editor UI in the CP” → likely a *fieldtype*
   - “I need to know what data exists here” → likely *variables* (scope)

2) **Go to the root index** (all-*) and locate the item
   - use browser find or search (see “Mirror search” below)

3) **Open the concrete item page and confirm**
   - parameters (names + defaults)
   - expected input/output type
   - scope limitations (where it works)
   - examples

4) **Implement the smallest working snippet**
   - no conditionals, no partials, no caching

5) **Only then compose**
   - chaining modifiers
   - adding conditionals/partials
   - enabling caching

---

## Mirror search (fastest)

If you have a local clone of the docs, searching it is usually faster than navigating the site.

```bash
# 1) update mirror
./scripts/update_statamic_docs.sh

# 2) search (prefers rg; grep fallback)
./scripts/search_statamic_docs.sh --ignore-case --context 2 "form-errors"
./scripts/search_statamic_docs.sh --ignore-case --context 2 "nav-breadcrumbs"
./scripts/search_statamic_docs.sh --ignore-case --context 2 "regex_replace"
```

Tips:
- Search by **slug** (e.g. `form-errors`, `nav-breadcrumbs`, `regex_replace`).
- If you remember a parameter name, search that parameter to find the right tag.

---

## Debugging checklist (practical)

### A) Scope + data shape
- Confirm you are in the correct context:
  - inside `{{ form }}` you get form-related variables; outside you don’t.
  - nav-related tags/vars often require a nav handle / tree.
- Confirm whether you have:
  - a single item vs a list
  - raw vs augmented values

### B) Reduce to a minimal repro
- Reduce template to 5–15 lines.
- Hardcode the inputs.
- Remove partials and components.

### C) Caching/staleness
If you “fix” something but output doesn’t change:
- check static caching is not serving old HTML
- check Stache / caches are not masking updates
- temporarily disable caching for the page/partial to confirm the template logic is correct

---

## Pitfalls (common gotchas)

- **Wrong section**: there are tags, variables, and fieldtypes with similar names.
- **Context mismatch**: a variable exists only inside a given tag scope.
- **Case/slug mismatch**: use the exact slug in searches.
- **Caching**: you’re debugging the wrong output (cached page vs template change).

---

## Policy for expanding this playbook (to keep it sustainable)

- We do **not** create per-tag/per-modifier playbooks.
- If a small set is high-impact for the project (typical: `nav`, `form`, `glide`, `cache`, `search`), we add a **short subsection** here with:
  - 1 working example
  - 2–3 key params
  - 2 common pitfalls
  - link to the official item page
