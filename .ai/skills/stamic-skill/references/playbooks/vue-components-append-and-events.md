# Vue Components: Appending + Events

**Summary:** Statamic’s CP provides a small API for appending registered Vue components to named mount points, then interacting with them (update props, listen to emitted events, destroy).

## Steps
1. Register your component in `Statamic.booting()`:
   ```js
   import MyComponent from './Components/MyComponent.vue'

   Statamic.booting(() => {
     Statamic.$components.register('my-component', MyComponent)
   })
   ```
2. Append it:
   ```js
   const component = Statamic.$components.append('publish-confirmation', {
     props: { foo: 'bar' },
   })
   ```
3. Update props:
   ```js
   component.prop('foo', 'baz')
   ```
4. Listen to emitted events:
   - in Vue: `this.$emit('event-name', { foo: 'bar' })`
   - outside:
     ```js
     component.on('event-name', (payload) => {
       console.log(payload)
     })
     ```
5. Clean up:
   ```js
   component.destroy()
   ```

## Gotchas
- `append()` requires a valid CP mount point name.
- Prefer destroying appended components when leaving the page / after completion.

## Sources
- https://statamic.dev/vue-components/overview
