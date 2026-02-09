# Tags / Modifiers / Fieldtypes / Variables — meta (Statamic 6)

Purpose: avoid exploding playbooks into hundreds of per-tag/per-modifier pages.
Instead, keep a **single meta playbook** with:
- how to navigate the reference docs
- how to search fast (local mirror)
- debugging patterns
- canonical “index” pages to start from

---

## When to use this playbook

Use this when you need:
- the right **tag** name + parameters
- the right **modifier** + chaining examples
- which **fieldtype** to use / common gotchas
- what **variables** exist in a given scope (entry, nav, form, glide, etc.)

For exact syntax/params, jump to the official reference docs (links below) and/or search the docs mirror.

---

## Official reference roots (start here)

- Tags
  - Overview: https://statamic.dev/tags/overview
  - All tags: https://statamic.dev/tags/all-tags

- Modifiers
  - Overview: https://statamic.dev/modifiers/overview
  - All modifiers: https://statamic.dev/modifiers/all-modifiers

- Fieldtypes
  - Overview: https://statamic.dev/fieldtypes/overview
  - All fieldtypes: https://statamic.dev/fieldtypes/all-fieldtypes

- Variables
  - All variables: https://statamic.dev/variables/all-variables

---

## Fast lookup workflow (recommended)

1) Start from the **index** page (all-tags / all-modifiers / all-fieldtypes / all-variables).
2) Identify the page for the concrete item.
3) Read:
   - what it does
   - parameters
   - examples
   - return values / scope
4) Cross-check with your current context:
   - Antlers vs Blade
   - entries vs terms vs nav vs assets vs forms
   - multisite / localization

---

## Local mirror search (offline-ish)

If the docs mirror exists locally, searching is the fastest way to find relevant pages/snippets:

```bash
# update mirror
./scripts/update_statamic_docs.sh

# search (prefer rg; grep fallback)
./scripts/search_statamic_docs.sh --ignore-case --context 2 "form-errors"
./scripts/search_statamic_docs.sh --ignore-case "modifier:markdown"
```

Tips:
- Search by the exact slug (e.g. `form-errors`, `regex_replace`, `nav-breadcrumbs`).
- Search for parameter names when you don’t remember the tag.

---

## Debugging patterns (practical)

### 1) Reduce to minimal template
- Strip the template down to 5–10 lines.
- Hardcode inputs first (no conditionals, no loops).

### 2) Inspect data shape
- In Antlers, use the official debugging helpers (see Advanced Topics → Debugging).
- Verify if you’re dealing with:
  - a single item vs a collection
  - augmented values vs raw values

### 3) Validate scope
Common gotcha: tags/variables only exist in certain contexts.
Example: inside `{{ form }}` you get form-related variables that don’t exist outside.

### 4) Verify caching boundaries
If output doesn’t change:
- check static caching / stache
- check if the template/partials are cached
- use nocache/disable caching only for debugging

---

## How we keep this sustainable

- We don’t create per-tag/per-modifier playbooks.
- If a tag/modifier is critical for your project (e.g. `nav`, `form`, `glide`, `cache`), we may add a **small focused section** here with 1–2 examples.
- Everything else: link to canonical docs + mirror search.
