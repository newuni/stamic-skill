# Frontend: Overview

**Summary:** In Statamic, “frontend” is everything that renders what users see (views/templates, JS/CSS, media assets). The CP is separate (content management). Statamic supports many frontend approaches; the recommended “path of least resistance” is Antlers or Blade + your own HTML + Tailwind + Vite.

**When to use:**
- Picking a frontend strategy for a Statamic 6 project.
- Explaining the request lifecycle and what parts are “frontend vs backend vs CP”.

## Steps
1. Decide your frontend approach:
   - Antlers-driven site (tight Statamic integration)
   - Blade-driven site (Laravel-style MVC or reuse existing Blade)
   - Headless (REST/GraphQL) + SPA
   - Static/JAMStack options
2. If no strong constraints, prefer:
   - write your HTML
   - use Antlers or Blade to pull content in
   - TailwindCSS for styling
   - Vite for bundling
3. Understand request lifecycle:
   - URL hit → Statamic resolves data (entry or statamic route)
   - variables loaded
   - view/template rendered with variables
   - HTML returned to browser

## Pitfalls / gotchas
- Tooling choices are flexible; keep it simple unless requirements force complexity.

## Sources
- https://statamic.dev/frontend/overview
