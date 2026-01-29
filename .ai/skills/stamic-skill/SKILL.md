---
name: stamic-skill
description: Statamic 6 development skill: documentation-backed guidance from statamic.dev + the statamic/docs mirror, with actionable steps/snippets for blueprints, Antlers, tags, addons, CP, caching, and common workflows. Designed to complement Laravel Boost v2 skills (Laravel-side) by handling Statamic-specific concepts.
---

# stamic-skill (Statamic 6 Dev)

Skill para desarrollo con **Statamic 6**. Prioriza `statamic.dev` y usa el mirror `statamic/docs` para búsquedas rápidas. Responde con pasos accionables, snippets mínimos, pitfalls y enlaces citados.

> Nota: esta carpeta (`.ai/skills/stamic-skill/`) es el formato recomendado para **Laravel Boost v2**.

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

4. **Coordinar con Laravel Boost v2 (complementario)**
   - Usa **Boost** para temas Laravel puros: Artisan, Eloquent/DB, queues, testing, service container, config, debugging.
   - Usa **stamic-skill** para temas Statamic: content modeling (blueprints/fieldsets/fields), entries/terms/assets, Antlers/tags/modifiers, CP/extending, Stache/cache, multi-site.
   - Si una petición mezcla ambos mundos, divide la respuesta: primero Statamic (qué hace/convención), luego Laravel (cómo se implementa).

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
./scripts/update_statamic_docs.sh
```

2) Search locally:
```bash
./scripts/search_statamic_docs.sh "your query"
```

If the query is broad, narrow it with ripgrep flags:
```bash
./skills/statamic-6-dev/scripts/search_statamic_docs.sh "antlers" -- -n --glob '!**/README.md'
```
