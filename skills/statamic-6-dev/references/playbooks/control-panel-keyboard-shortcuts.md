# Control Panel: Keyboard Shortcuts

**Summary:** You can add CP keyboard shortcuts via `Statamic.$keys` (Mousetrap-like). Bind shortcuts in Vue components and destroy bindings when the component unmounts.

**When to use:**
- Improving CP UX for custom pages/components.

## Steps
1. Bind in `onMounted`, destroy in `onBeforeUnmount`:
   ```js
   import { ref, onMounted, onBeforeUnmount } from 'vue'

   const binding = ref(null)

   onMounted(() => {
     binding.value = Statamic.$keys.bind('mod+s', save)
   })

   onBeforeUnmount(() => {
     binding.value?.destroy()
   })
   ```
2. Use `bindGlobal` if shortcut must work inside text inputs.
3. Use `mod` for ctrl/cmd portability.
4. Key sequences can be combos (`shift+/`) or sequences (`up up down down`).

## Pitfalls / gotchas
- Always destroy bindings in transient UI (modals/stacks) to restore previous bindings.

## Sources
- https://statamic.dev/control-panel/keyboard-shortcuts
