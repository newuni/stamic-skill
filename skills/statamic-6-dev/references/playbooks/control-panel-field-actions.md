# Control Panel: Field Actions

**Summary:** Field actions are JavaScript-powered actions attached to individual fields (or Bard/Replicator sets) in publish forms. They can manipulate values, prompt confirmations, show loading state, and expose quick-action icons.

**When to use:**
- Add “transform” actions near fields (uppercase, translate, format, etc.).

## Steps
1. Register a field action:
   ```js
   Statamic.$fieldActions.add('text-fieldtype', {
     title: 'Reverse',
     run: ({ value, update }) => update(value.split('').reverse().join('')),
   })
   ```
2. Attach to contexts:
   - `'text-fieldtype'`
   - `'bard-fieldtype-set'`
   - `'replicator-fieldtype-set'`
3. Optional: define actions internally in a fieldtype via `internalFieldActions` computed.
4. Loading state:
   - return a Promise from `run()`.
5. Quick action icon:
   ```js
   { quick: true, icon: 'light/crane' }
   ```
   (can be functions).
6. Visibility:
   - `visible: true` or function; `visibleWhenReadOnly: true` if needed.
7. Confirmation modals:
   ```js
   {
     confirm: { title: 'My Modal', text: 'Are you sure?', fields: { name: { type: 'text' } } },
     run: ({ confirmation }) => console.log(confirmation.processed),
   }
   ```
8. Access other fields via publish store:
   - `store.state.publish[storeName].values`.

## Pitfalls / gotchas
- Field actions are for fields/sets; use “Actions” for bulk item actions.

## Sources
- https://statamic.dev/control-panel/field-actions
