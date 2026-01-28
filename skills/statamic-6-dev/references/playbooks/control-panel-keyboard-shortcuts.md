# Control Panel: Keyboard Shortcuts

**Summary:** You can add custom keyboard shortcuts in the Control Panel using the `Statamic.$keys` helper (Mousetrap-style). Bind/unbind in Vue component lifecycle to avoid leaking bindings.

**When to use:**
- Building addons / CP extensions that benefit from keyboard shortcuts.

## Steps
1. Bind a shortcut (use `mod` for cmd/ctrl portability):
   - `Statamic.$keys.bind('mod+s', save)`
2. Store the returned Binding and destroy it when the component unmounts.
3. Use `bindGlobal` if the shortcut should work inside text inputs.
4. Define sequences:
   - single key (`/`)
   - combo (`shift+/`)
   - sequence (`up up down down`)

## Pitfalls / gotchas
- Always destroy bindings in components that may disappear (modals/stacks), so previous bindings can restore.

## Sources
- https://statamic.dev/control-panel/keyboard-shortcuts
