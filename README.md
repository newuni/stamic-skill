# stamic-skill (Statamic 6 Dev)

Skill local para Clawdbot orientada a **desarrollo con Statamic 6**: busca documentación oficial (statamic.dev + mirror `statamic/docs`) y responde con pasos accionables, citas y snippets.

> Nota: para **Laravel Boost v2**, el *skill key* y el `name:` del `SKILL.md` son **`stamic-skill`**.
> 
> Para compatibilidad con el entorno anterior de Clawdbot, también existe la carpeta histórica `skills/statamic-6-dev/` (mismo contenido, distinta ruta).

## Qué incluye

- `skills/statamic-6-dev/SKILL.md` — instrucciones de uso y workflow de la skill.
- `skills/statamic-6-dev/references/playbooks/` — playbooks cortos y accionables por tema (Control Panel, Frontend, Addons, Advanced Topics…).
- `skills/statamic-6-dev/references/playbook-map.md` — mapa de cobertura de docs → playbooks (estado, links canónicos, pendientes).
- `skills/statamic-6-dev/scripts/` — scripts para actualizar y buscar en el mirror de docs.

## Instalación

### Laravel Boost v2 (instalación recomendada)

Este repo incluye el formato Boost v2 bajo:

- `.ai/skills/stamic-skill/`

**Prerequisito:** tener Boost v2 instalado en el proyecto.

```bash
composer require laravel/boost:^2
php artisan boost:install
```

**Instalar la skill desde GitHub:**

```bash
php artisan boost:add-skill newuni/stamic-skill/.ai/skills
```

Eso instalará `stamic-skill` como skill local dentro del proyecto.

**Actualizar / re-sincronizar:**
- Vuelve a ejecutar `boost:add-skill` (Boost v2 hace sync de skills).
- Si usas overrides en el proyecto, revisa la sección de overrides de Boost v2.

### Clawdbot (uso en local)

En Clawdbot puedes usarla en local mediante un symlink dentro del workspace:

```bash
cd /root/clawd
# opción recomendada (apunta al formato Boost, mismo contenido)
ln -sfn ../projects/stamic-skill/.ai/skills/stamic-skill skills/stamic-skill

# opción legacy (mantiene la ruta histórica)
# ln -sfn ../projects/stamic-skill/skills/statamic-6-dev skills/stamic-skill
```

Con eso, Clawdbot puede “ver” la skill como `stamic-skill`.

## Cómo usarla (prompts ejemplo)

- “Usa la skill **stamic-skill** y dime cómo gestionar los assets.”
- “Quiero añadir una sección al CP nav en un addon. Dame pasos + código.”
- “¿Cómo hago el bundle/build de assets del addon con Vite?”
- “Busca en la doc oficial cómo funcionan las Field Actions y dame un ejemplo.”

**Criterios de respuesta esperados**
- pasos 1..N
- snippets mínimos
- pitfalls/gotchas
- links a statamic.dev (y si aplica, ruta del markdown en `statamic/docs`)

## Playbooks

Los playbooks viven en:

```
skills/statamic-6-dev/references/playbooks/
```

Son documentos pequeños (idealmente 1 pantalla) con:
1) resumen
2) 3–7 pasos
3) pitfalls
4) fuentes

El estado y cobertura se controla en:

- `skills/statamic-6-dev/references/playbook-map.md`

## Actualizar y buscar docs (mirror)

Actualizar el mirror local del repositorio `statamic/docs`:

```bash
./skills/statamic-6-dev/scripts/update_statamic_docs.sh
```

Buscar en el mirror:

```bash
./skills/statamic-6-dev/scripts/search_statamic_docs.sh "your query"
```

## Notas / decisiones

- Siempre preferimos **statamic.dev** como fuente de verdad.
- Si una URL cambió (p.ej. páginas movidas en 6.x), se actualiza el `playbook-map.md`.
- Algunas páginas pueden no existir en 6.x (se deja anotado como *missing/removed*).

## Contribuir

- Añade/edita un playbook en `references/playbooks/`.
- Actualiza el `playbook-map.md` (estado + URL canónica).
- Mantén el contenido conciso y con citas.
