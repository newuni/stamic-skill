# Vue Components: Recipes (CP extensions)

**Summary:** Practical patterns for extending the Statamic Control Panel with Vue components, across addons, utilities, widgets, actions, and fieldtypes.

## Recipe 1: Register a component (addon)

1. Ensure your addon loads CP JS via Vite (see `addons-vite-tooling.md`).
2. In `resources/js/addon.js`:
   ```js
   import MyComponent from './components/MyComponent.vue'

   Statamic.booting(() => {
     Statamic.$components.register('my-component', MyComponent)
   })
   ```
3. Use the component from other CP extension points (widgets, fieldtypes, appended mount points).

## Recipe 2: Register an Inertia page and use it in a Utility

1. Register your Inertia page:
   ```js
   import DataTool from './pages/DataTool.vue'

   Statamic.booting(() => {
     Statamic.$inertia.register('my-addon::DataTool', DataTool)
   })
   ```
2. Register a utility that renders that page:
   ```php
   use Statamic\Facades\Utility;

   Utility::extend(function () {
     Utility::register('data_tool')
       ->inertia('my-addon::DataTool', fn () => [
         'items' => Item::all(),
       ])
       ->title('Data Tool');
   });
   ```
3. In the page, use Inertia components from `@statamic/cms/inertia` (`Head`, `Link`, `router`).

## Recipe 3: Append a component to a CP mount point

Use this when you need a small UI injection (confirmation, extra panel, etc.) without creating a whole route.

```js
const instance = Statamic.$components.append('publish-confirmation', {
  props: { foo: 'bar' },
})

// listen to emitted events
instance.on('done', (payload) => {
  // ...
})

// update props
instance.prop('foo', 'baz')

// cleanup when finished / on page change
instance.destroy()
```

Notes:
- You must have registered the component name ahead of time.
- The mount point name must exist in Statamic’s CP.
- Always `destroy()` appended components to avoid leaks / duplicate UI.

## Recipe 4: Action → JS callback (e.g. copy to clipboard)

In your Action `run()` return a callback response:
```php
return [
  'callback' => ['copyToClipboard', 'some text'],
];
```

For custom callbacks:
```php
return [
  'callback' => ['myCallback', 'arg1', 'arg2'],
];
```
Register on JS side:
```js
Statamic.booting(() => {
  Statamic.$callbacks.add('myCallback', (a, b) => {
    console.log(a, b)
  })
})
```

## Recipe 5: Fieldtype UI uses Statamic UI components

Inside fieldtype Vue components:
```vue
<script setup>
import { Fieldtype } from '@statamic/cms'
import { Input, Button } from '@statamic/cms/ui'

const emit = defineEmits(Fieldtype.emits)
const props = defineProps(Fieldtype.props)
const { expose, update } = Fieldtype.use(emit, props)

defineExpose(expose)
</script>
```

## Recipe 6: Widget UI uses the <Widget> wrapper

```vue
<script setup>
import { Widget } from '@statamic/cms/ui'

defineProps(['message'])
</script>

<template>
  <Widget title="My Widget">
    <div class="px-4 py-3">{{ message }}</div>
  </Widget>
</template>
```

## Sources
- https://statamic.dev/vue-components/overview
- https://statamic.dev/control-panel/utilities
- https://statamic.dev/widgets/building-a-widget
- https://statamic.dev/backend-apis/actions
- https://statamic.dev/fieldtypes/build-a-fieldtype
- https://ui.statamic.dev
