---
name: stamic-skill
description: Statamic 6 development skill with documentation-backed guidance from statamic.dev + the statamic/docs mirror. Includes actionable steps/snippets for blueprints, Antlers, tags, addons, CP, caching, and common workflows.
license: MIT
metadata:
  author: newuni
  version: "1.0.1"
---

# stamic-skill (Statamic 6 Dev)

Provide Statamic 6 documentation-backed guidance and implementation help, optimized for developer workflows.

## Workflow (recommended)

1. **Clarify target + context**
   - Confirm: Statamic **6** (and Laravel version), project type (fresh vs existing), and whether the request is **Statamic-specific** (content model, Antlers, blueprints, structures) vs **Laravel-specific** (DB, Eloquent, queues, debugging).

2. **Prefer canonical docs, but keep it searchable**
   - Use **statamic.dev** for canonical explanations.
   - Use **GitHub mirror** (statamic/docs) for fast full-text search, diffs, and linking to exact Markdown.
   - If information conflicts, treat **statamic.dev** as source of truth and mention the discrepancy.

3. **Search → quote → answer**
   - Search for the relevant page/section.
   - Answer with short, actionable steps.
   - Include links (statamic.dev and/or specific docs file paths) so the team can verify.

4. **Coordinate with Laravel Boost (complementary)**
   - Use Laravel Boost guidance/tools for Laravel framework concerns (Artisan, Eloquent, debugging, environment).
   - Use this skill for Statamic concepts and conventions (blueprints/fieldsets, entries, taxonomies, Antlers, tags/modifiers, Stache/cache, sites).

## What to do for common requests

### “Find the latest docs for X”
- Search the GitHub mirror first (fast), then open the canonical statamic.dev page.
- Provide: the best page link, the key excerpt/summary, and 1–3 do/don’t bullets.

### “How do we implement X in Statamic 6?”
- Return a minimal implementation plan + code/config snippets.
- Call out:
  - where files live (blueprints, templates, addons)
  - expected conventions/naming
  - caches to clear (when relevant)

### “Is this best practice / is this supported in v6?”
- Confirm version explicitly.
- Prefer citing a doc section or a clear upstream source.

## Bundled resources

### references/
- `references/sources.md`: canonical sources and how to treat them.
- `references/statamic-mcp-notes.md`: lightweight domain taxonomy + response checklist inspired by statamic-mcp.

### scripts/
Use these scripts when you need deterministic, repeatable doc lookup.

1) Update local docs mirror (repo maintenance script):
```bash
./dev-scripts/update_statamic_docs.sh
```
Use this from the source repository root. Installed runtime skill copies may not include `dev-scripts/`.

2) Search locally:
```bash
./scripts/search_statamic_docs.sh "your query"
```

If the query is broad, narrow it with ripgrep flags:
```bash
./scripts/search_statamic_docs.sh --top 20 "antlers"
```
