# stamic-skill (Statamic 6 Dev)

An agent skill for **Statamic 6** development.

- Source of truth: **statamic.dev**

This repository contains a single skill layout:

- `skills/stamic-skill/`

## What’s inside

- `skills/stamic-skill/SKILL.md` — main skill instructions and workflow.
- `skills/stamic-skill/references/playbooks/` — short, actionable playbooks.
- `skills/stamic-skill/references/playbook-map.md` — coverage map (official docs → playbooks).
- `skills/stamic-skill/scripts/search_statamic_docs.sh` — helper to search a local docs mirror (optional).

## Install / Update (Codex via `npx skills`)

List available skills in this repo:

```bash
npx skills add newuni/stamic-skill --list
```

Install for Codex (global):

```bash
npx skills add newuni/stamic-skill --skill stamic-skill --agent codex -g -y
```

Update / re-sync:

```bash
npx skills add newuni/stamic-skill --skill stamic-skill --agent codex -g -y
```

Force a clean reinstall (optional):

```bash
npx skills remove stamic-skill --agent codex -g -y
npx skills add newuni/stamic-skill --skill stamic-skill --agent codex -g -y
```

## Contributing

- Add/edit playbooks in `skills/stamic-skill/references/playbooks/`.
- Keep playbooks small: summary → steps → pitfalls → sources.
- Update `skills/stamic-skill/references/playbook-map.md` accordingly.
