# stamic-skill (Statamic 6 Dev)

Skill (formato legacy para Clawdbot) para desarrollo con **Statamic 6**.

- Archivo principal: `SKILL.md`
- Playbooks: `references/playbooks/`
- Mapa de cobertura: `references/playbook-map.md`
- Scripts (mirror + búsqueda): `scripts/`

## Qué hace

- Prioriza documentación oficial de **statamic.dev**.
- Complementa con el mirror **statamic/docs** para búsquedas rápidas.
- Responde con pasos accionables + snippets + pitfalls + links citados.

## Cómo usarla

Ejemplos de prompts:
- “Usa la skill **stamic-skill** y dime cómo gestionar los assets.”
- “¿Cómo añado una sección en el CP nav desde un addon?”
- “Hazme el bundle/build de assets del addon (JS/CSS) con Vite.”

## Validación rápida

- Comprueba que Clawdbot descubre la carpeta como `stamic-skill` (según cómo la instales en tu workspace).
- Si no aparece, reinicia el gateway.
- Usa `references/playbook-map.md` para ver qué temas están listos (`REFINED`) vs pendientes.

## Notas

- `statamic.dev` manda si hay discrepancias.
- Si alguna URL cambió o desapareció en 6.x, se anota en el map.
