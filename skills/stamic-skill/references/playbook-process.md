# Playbook conversion process (Statamic 6)

Goal: consistently convert Statamic documentation into small, reusable playbooks optimized for LLM use (Codex / Claude Code / OpenCode).

## Input

- Canonical docs page on statamic.dev (primary)
- Optional supporting pages (related tips, API reference pages)
- Optional local mirror reference (statamic/docs) for quoting exact sections

## Output

Create one file per playbook:
- Path: `skills/stamic-skill/references/playbooks/<slug>.md`
- Keep each playbook short and task-oriented.

Update status in `references/playbook-map.md`:
- `PENDING` → `DRAFTED` when a playbook file exists
- `DRAFTED` → `REFINED` after a second pass (clarity, steps, pitfalls, links)

## Procedure (repeatable)

1) **Confirm scope and version**
   - Assume Statamic 6.
   - If the page explicitly targets older versions, mark in Notes and adapt cautiously.

2) **Extract the “developer question”**
   - Rewrite the page into 1–3 questions a dev would ask (e.g., “How do we do X safely in production?”).

3) **Build the playbook skeleton**
   - Title
   - 1-paragraph summary
   - “When to use” bullets
   - Steps (3–7)
   - Pitfalls / gotchas (only what is likely to bite)
   - “Sources” section with links

4) **Write actionable steps**
   - Prefer concrete file paths, config keys, and minimal snippets.
   - Avoid long explanations; link out to the docs instead.

5) **Cite sources precisely**
   - Always include the statamic.dev URL.
   - If useful, add a “Docs anchor” (section heading) so it’s quickly verifiable.
   - Optionally include the statamic/docs path if/when we have the local mirror updated.

6) **Add Laravel coordination note (only if relevant)**
   - If the topic touches Laravel infrastructure (cache stores, Redis config, deployment hooks), add a short line:
     - “Laravel-side: follow official Laravel docs/project conventions for …”

7) **Second pass (for REFINED)**
   - Remove fluff.
   - Ensure steps are executable.
   - Ensure pitfalls are real and not speculative.
   - Ensure link list is minimal and correct.

## Playbook template

```md
# <Playbook title>

**Summary:** <1 paragraph>

**When to use:**
- <bullet>

## Steps
1. <step>
2. <step>

## Pitfalls / gotchas
- <bullet>

## Sources
- <statamic.dev URL>
- <optional related URL>
```

## Quality bar

A playbook is acceptable when:
- It can be followed without reading the full doc first.
- It has at least one authoritative link.
- It avoids speculative claims.
- It stays short enough to be loaded into context without crowding the prompt.
