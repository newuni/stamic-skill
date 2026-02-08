# Vue Components: Overview (Extending the CP)

**Summary:** You can register custom Vue 3 components for the Statamic Control Panel and either use them directly or append them dynamically to specific mount points.

**When to use:**
- CP extensions: custom UI blocks, dialogs, publish confirmations, etc.

## Steps
1. Register your component during boot:
   ```js
   import MyComponent from './Components/MyComponent.vue';

   Statamic.booting(() => {
     Statamic.$components.register('my-component', MyComponent);
   });
   ```
2. Optionally append a registered component to a mount point:
   ```js
   const component = Statamic.$components.append('publish-confirmation', {
     props: { foo: 'bar' }
   });
   ```
3. Interact with appended component:
   - update props: `component.prop('prop-name', newValue)`
   - listen to events: `component.on('event-name', handler)`
   - destroy: `component.destroy()`

## Pitfalls / gotchas
- Register inside `Statamic.booting()` to ensure CP has booted.

## Sources
- https://statamic.dev/vue-components/overview
