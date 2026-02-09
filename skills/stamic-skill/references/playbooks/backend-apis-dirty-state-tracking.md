# Backend & APIs: Dirty State Tracking

**Summary:** This page is currently a placeholder in Statamic 6 docs. For practical work, rely on published CP extension patterns (fieldtypes/widgets/utilities/actions) and standard save/publish flows instead of undocumented internal dirty-state internals.

**When to use:**
- You are building CP UI and need to reason about unsaved/modified state.
- You found legacy references to dirty-state APIs and need a safe 6.x approach.

## Steps
1. Build CP interactions through documented extension points (fieldtypes, utilities, widgets, actions).
2. Use standard save/publish lifecycle and validation hooks rather than internal state assumptions.
3. Test unsaved-change behavior directly in the CP flow you are extending.
4. If you require deep internals, inspect current source and treat findings as implementation details.

## Pitfalls / gotchas
- Internal dirty-state behavior may change between versions without public API guarantees.
- Reusing old examples from pre-6 docs can produce brittle custom CP behavior.

## Sources
- https://statamic.dev/backend-apis/dirty-state-tracking
