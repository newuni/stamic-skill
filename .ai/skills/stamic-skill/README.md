# stamic-skill (Boost v2 compatible)

Este directorio contiene la skill en el formato esperado por **Laravel Boost v2** (`.ai/skills/<skill>/...`).

## Instalación (Boost v2)

### 1) Instala/actualiza Boost v2 en tu proyecto

```bash
composer require laravel/boost:^2
php artisan boost:install
```

### 2) Añade esta skill desde GitHub

```bash
php artisan boost:add-skill newuni/stamic-skill/.ai/skills
```

Esto instalará `stamic-skill` como skill local dentro del proyecto.

### 3) Verificación rápida

- Comprueba que existe una carpeta instalada para la skill (según cómo Boost la materialice en tu proyecto).
- Pídele a tu asistente algo como: “Usa la skill stamic-skill y explícame cómo gestionar assets en Statamic”.

### Troubleshooting

- Si la skill “no aparece”, re-sincroniza:
  ```bash
  php artisan boost:add-skill newuni/stamic-skill/.ai/skills
  ```
- Si usas overrides, asegúrate de no estar reemplazando `stamic-skill`.

### Actualizar

Vuelve a ejecutar `boost:add-skill ...` para re-sincronizar.

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
