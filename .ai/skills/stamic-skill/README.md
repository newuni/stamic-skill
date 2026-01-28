# stamic-skill (Boost v2 compatible)

Este directorio contiene la skill en el formato esperado por **Laravel Boost v2** (`.ai/skills/<skill>/...`).

## Instalación (Boost v2)

Desde un proyecto Laravel:

```bash
php artisan boost:add-skill newuni/stamic-skill/.ai/skills
```

Eso instalará `stamic-skill` como skill local dentro del proyecto.

## Qué incluye

- `SKILL.md` — guía de uso + workflow.
- `references/playbooks/` — playbooks cortos por tema (Frontend, CP, Addons, Advanced Topics...).
- `references/playbook-map.md` — mapa de cobertura de docs → playbooks.
- `scripts/` — scripts para actualizar/buscar en el mirror `statamic/docs`.

## Cómo encaja con Boost

- **Boost**: Laravel framework (Eloquent/DB, queues, testing, service container, etc.).
- **stamic-skill**: Statamic (blueprints, entries, Antlers, tags/modifiers, addons, CP, Stache/cache).

## Nota

La fuente de verdad para conceptos es **https://statamic.dev**. Si el mirror `statamic/docs` difiere, se prioriza `statamic.dev`.
