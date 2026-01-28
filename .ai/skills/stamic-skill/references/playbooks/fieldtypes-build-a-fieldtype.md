# Fieldtypes: Build a Fieldtype

**Summary:** Custom fieldtypes have a PHP class + a Vue component for the Control Panel. Generate scaffolding with `php please make:fieldtype`, register the Vue component in your CP JS entry (cp.js), and optionally add config fields, processing, augmentation, and index display.

**When to use:**
- You need a custom authoring UI or storage format.
- You want a specialized field experience in blueprints.

## Steps
1. Ensure CP JavaScript is loading (ideally via Vite). Verify with a simple `alert('It works!')`.
2. Generate scaffolding:
   ```bash
   php please make:fieldtype TogglePassword
   ```
3. Vue component:
   - created under `resources/js/components/fieldtypes/<Name>.vue`
   - register in `cp.js`:
     ```js
     Statamic.booting(() => {
       Statamic.$components.register('uppercase-fieldtype', UppercaseFieldtype);
     });
     ```
   - use the `Fieldtype` composable for props/emits and call `update(...)`.
4. PHP class:
   - create under `App\Fieldtypes` extending `Statamic\Fields\Fieldtype`
   - auto-registered if in `App\Fieldtypes`, otherwise call `YourFieldtype::register()`.
5. Add optional UX metadata:
   - icon (`$icon` or `icon()`)
   - categories (`$categories`)
   - keywords (`$keywords`)
6. Add config fields via `configFieldItems()`; access in Vue via `config`.
7. Handle value transformation:
   - `preProcess` / `process`
   - `preload` meta + `updateMeta`
8. Improve list/index display:
   - `preProcessIndex` and/or a dedicated index Vue component.
9. Add augmentation via `augment($value)` if needed.

## Pitfalls / gotchas
- Don’t mutate `props.value` directly; always use `update()`/`updateDebounced()`.
- Ensure your component registration name matches the expected handle naming (`snake_case_handle-fieldtype`).

## Sources
- https://statamic.dev/fieldtypes/build-a-fieldtype
