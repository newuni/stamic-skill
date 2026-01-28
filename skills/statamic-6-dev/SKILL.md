---
name: statamic-6-dev
description: Statamic 6 development assistant skill focused on retrieving the most up-to-date Statamic documentation and best practices from statamic.dev and the statamic/docs GitHub mirror, then applying them in real code changes (blueprints, collections, entries, Antlers, tags, addons). Use when working on a Statamic 6 project and you need authoritative doc lookup, version-aware guidance, or to coordinate Statamic-specific guidance alongside Laravel Boost (Laravel-side tooling) for a complete workflow.
---

# Statamic 6 Dev

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

1) Update local docs mirror:
```bash
./skills/statamic-6-dev/scripts/update_statamic_docs.sh
```

2) Search locally:
```bash
./skills/statamic-6-dev/scripts/search_statamic_docs.sh "your query"
```

If the query is broad, narrow it with ripgrep flags:
```bash
./skills/statamic-6-dev/scripts/search_statamic_docs.sh "antlers" -- -n --glob '!**/README.md'
```
