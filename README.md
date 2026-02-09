# stamic-skill (Statamic 6 Dev)

An agent skill for **Statamic 6** development.

- Source of truth: **statamic.dev**

This repository contains a single skill layout:

- `skills/stamic-skill/`

## What’s inside

- `skills/stamic-skill/SKILL.md` — main skill instructions and workflow.
- `skills/stamic-skill/references/playbooks/` — short, actionable playbooks.
- `skills/stamic-skill/references/playbook-map.md` — coverage map (official docs → playbooks).
- `skills/stamic-skill/scripts/update_statamic_docs.sh` — runtime bootstrap/update for local docs mirror (with lock + atomic clone).
- `skills/stamic-skill/scripts/search_statamic_docs.sh` — helper to search a local docs mirror (optional; waits for in-progress updates).
- `dev-scripts/` — repo-maintenance tooling (mirror update, smoke checks, consistency checks).

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

## Repo Maintenance Scripts

Run these from the repository root:

```bash
./dev-scripts/update_statamic_docs.sh
./dev-scripts/check_repo_consistency.sh
./dev-scripts/generate_playbook_index.sh
./dev-scripts/check_playbook_sync.sh
./dev-scripts/smoke_statamic_docs.sh
```

Expected smoke result:

```text
[smoke] OK
```

## Daily Automation

The workflow `.github/workflows/daily-docs-sync-release.yml` runs every day (`03:17 UTC`) and can also be triggered manually.

Behavior:
- Updates the local Statamic docs mirror.
- Compares mirror HEAD against `skills/stamic-skill/references/docs-mirror-head.txt`.
- If HEAD did not change: exits without release.
- If HEAD changed: runs quality checks, commits updated mirror revision/index, creates a tag `docs-sync-YYYYMMDD-<head>`, and publishes a GitHub release.

## Contributing

- Add/edit playbooks in `skills/stamic-skill/references/playbooks/`.
- Keep playbooks small: summary → steps → pitfalls → sources.
- Update `skills/stamic-skill/references/playbook-map.md` accordingly.
