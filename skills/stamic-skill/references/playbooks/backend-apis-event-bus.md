# Backend & APIs: Event Bus

**Summary:** The Event Bus page is currently a placeholder in Statamic 6 docs. For production code, use Laravel events/listeners for backend workflows and documented Statamic CP/Vue extension APIs for frontend/admin interactions.

**When to use:**
- You need decoupled backend actions after Statamic operations.
- You found old Event Bus references and need a supported 6.x path.

## Steps
1. Model backend integration through Laravel events/listeners.
2. For CP-side interactions, use documented JS callbacks/components/Inertia registration.
3. Keep event payload assumptions minimal and validate against current behavior.
4. If an older Event Bus pattern is required, verify in source before adopting it.

## Pitfalls / gotchas
- Legacy Event Bus examples can rely on internals that are not stable in 6.x.
- Mixing backend events with CP UI concerns without clear boundaries makes debugging difficult.

## Sources
- https://statamic.dev/backend-apis/event-bus
