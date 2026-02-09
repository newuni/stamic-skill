# stamic-skill (Statamic 6 Dev)

Skill local para Clawdbot orientada a **desarrollo con Statamic 6**: busca documentación oficial (statamic.dev + mirror `statamic/docs`) y responde con pasos accionables, citas y snippets.

> Nota: para **Laravel Boost v2**, el *skill key* y el `name:` del `SKILL.md` son **`stamic-skill`**.
>
> Este repo mantiene **dos formatos** con el mismo contenido:
> - Boost v2: `.ai/skills/stamic-skill/` (recomendado)
> - Formato “legacy”/workspace: `skills/stamic-skill/` (para symlink en Clawdbot u otros runners)

## Qué incluye

- `skills/stamic-skill/SKILL.md` — instrucciones de uso y workflow de la skill.
- `skills/stamic-skill/references/playbooks/` — playbooks cortos y accionables por tema (Control Panel, Frontend, Addons, Advanced Topics…).
- `skills/stamic-skill/references/playbook-map.md` — mapa de cobertura de docs → playbooks (estado, links canónicos, pendientes).
- `skills/stamic-skill/scripts/` — scripts para actualizar y buscar en el mirror de docs.

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

### Codex (OpenAI) vía `npx skills`

> Nota: si tú dices/usas “`npx skill`”, normalmente te refieres al CLI `skills`.

Si no quieres depender de Boost (o si `boost:add-skill` falla por red), puedes instalar la skill directamente en **Codex** usando el instalador estándar del ecosistema: [`skills` (Vercel)](https://github.com/vercel-labs/skills).

**Listar skills disponibles en el repo:**

```bash
npx skills add newuni/stamic-skill --list
```

**Instalar la skill para Codex (recomendado global):**

```bash
npx skills add newuni/stamic-skill --skill stamic-skill --agent codex -g -y
```

**Actualizar (update / re-sync):**

Re-ejecuta el mismo comando de `add` (es idempotente y fuerza a re-sincronizar el contenido):

```bash
npx skills add newuni/stamic-skill --skill stamic-skill --agent codex -g -y
```

Si quieres asegurarte de que estás cogiendo lo último:

```bash
# (opcional) borrar y re-instalar
npx skills remove stamic-skill --agent codex -g -y
npx skills add newuni/stamic-skill --skill stamic-skill --agent codex -g -y
```

- `--agent codex`: instala / enlaza la skill para Codex.
- `-g` / `--global`: instala en la configuración global del usuario (no solo en el proyecto actual).
- `-y` / `--yes`: evita prompts.

> Nota: Codex suele cargar skills desde `~/.codex/skills` (o desde `CODEX_HOME` si lo tienes definido). El comando anterior se encarga de colocarlo donde toca.

### Clawdbot (uso en local)

En Clawdbot puedes usarla en local mediante un symlink dentro del workspace:

```bash
cd /root/clawd
# opción recomendada (apunta al formato Boost, mismo contenido)
ln -sfn ../projects/stamic-skill/.ai/skills/stamic-skill skills/stamic-skill

# opción legacy
# ln -sfn ../projects/stamic-skill/skills/stamic-skill skills/stamic-skill
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
skills/stamic-skill/references/playbooks/
```

Son documentos pequeños (idealmente 1 pantalla) con:
1) resumen
2) 3–7 pasos
3) pitfalls
4) fuentes

El estado y cobertura se controla en:

- `skills/stamic-skill/references/playbook-map.md`

## Actualizar y buscar docs (mirror)

Actualizar el mirror local del repositorio `statamic/docs`:

```bash
./skills/stamic-skill/scripts/update_statamic_docs.sh
```

Buscar en el mirror:

```bash
./skills/stamic-skill/scripts/search_statamic_docs.sh "your query"
```

## Notas / decisiones

- Siempre preferimos **statamic.dev** como fuente de verdad.
- Si una URL cambió (p.ej. páginas movidas en 6.x), se actualiza el `playbook-map.md`.
- Algunas páginas pueden no existir en 6.x (se deja anotado como *missing/removed*).

## Troubleshooting

### Boost: la skill no aparece / no parece cargarse

1) Asegúrate de estar en Boost v2:
```bash
composer show laravel/boost
```
2) Reinstala / re-sincroniza:
```bash
php artisan boost:add-skill newuni/stamic-skill/.ai/skills
```
3) Si tienes overrides en el proyecto, revisa que no estés sobreescribiendo `stamic-skill`.

### Clawdbot: no veo `stamic-skill`

- Verifica el symlink:
```bash
ls -la /root/clawd/skills/stamic-skill
```
- Si no se refresca, reinicia el gateway de Clawdbot.

## Contribuir

- Añade/edita un playbook en `references/playbooks/`.
- Actualiza el `playbook-map.md` (estado + URL canónica).
- Mantén el contenido conciso y con citas.
