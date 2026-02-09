# stamic-skill (Statamic 6 Dev)

Skill (formato legacy) para desarrollo con **Statamic 6**.

- Archivo principal: `SKILL.md`
- Playbooks: `references/playbooks/`
- Mapa de cobertura: `references/playbook-map.md`
- Scripts (búsqueda en runtime): `scripts/`
- Scripts de mantenimiento del repo: `dev-scripts/` (en la raíz del repo)

## Qué hace

- Prioriza documentación oficial de **statamic.dev**.
- Complementa con el mirror **statamic/docs** para búsquedas rápidas.
- Responde con pasos accionables + snippets + pitfalls + links citados.

## Cómo usarla

Ejemplos de prompts:
- “Usa la skill **stamic-skill** y dime cómo gestionar los assets.”
- “¿Cómo añado una sección en el CP nav desde un addon?”
- “Hazme el bundle/build de assets del addon (JS/CSS) con Vite.”

## Scripts (mirror + búsqueda)

### 1) Descargar/actualizar el mirror de docs

```bash
./scripts/update_statamic_docs.sh
# o apuntar a otra carpeta
./scripts/update_statamic_docs.sh /tmp/statamic-docs
```

En este repositorio (mantenimiento), también existe:

```bash
./dev-scripts/update_statamic_docs.sh
```

### 2) Buscar en el mirror

```bash
./scripts/search_statamic_docs.sh "webauthn"
./scripts/search_statamic_docs.sh --context 2 "forms"
./scripts/search_statamic_docs.sh --docs-dir /tmp/statamic-docs "antlers"
```

Si el mirror local no existe, `search_statamic_docs.sh` lo bootstrappea automáticamente (puedes desactivarlo con `--no-bootstrap`).

Desde la raíz del repo también puedes usar el wrapper:

```bash
./dev-scripts/search_statamic_docs.sh "webauthn"
```

Recomendado: instalar `rg` (ripgrep). Si no, hace fallback a `grep` (más lento y con menos opciones).

## Validación rápida

- Desde la raíz del repo: `./dev-scripts/check_repo_consistency.sh`
- Regenerar índice: `./dev-scripts/generate_playbook_index.sh`
- Validar sync mapa↔playbooks: `./dev-scripts/check_playbook_sync.sh`
- Smoke mirror+búsqueda: `./dev-scripts/smoke_statamic_docs.sh`
- Si falta el mirror local de docs: ejecutar `./scripts/update_statamic_docs.sh` y repetir la búsqueda.
- Comprueba que tu agente descubre la carpeta como `stamic-skill` (según cómo la instales en tu workspace).
- Si no aparece, reinicia el gateway.
- Usa `references/playbook-map.md` para ver qué temas están listos (`REFINED`) vs pendientes.

## Notas

- `statamic.dev` manda si hay discrepancias.
- Si alguna URL cambió o desapareció en 6.x, se anota en el map.
