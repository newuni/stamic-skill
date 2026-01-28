# Control Panel: Publish Forms

**Summary:** Publish forms are Statamic’s blueprint-driven editing UI used for entries/etc. You can reuse them for your own models and custom CP features—either “simple” (server-rendered) via `PublishForm`, or “complex” using `PublishContainer` + `save-pipeline` in Vue.

**When to use:**
- Building custom CP CRUD that feels native.
- Editing non-Statamic models with blueprint fieldtypes.

## Steps
### A) Simple (no Vue required)
1. Return a publish form from a controller:
   ```php
   return PublishForm::make($blueprint)
     ->values($values)
     ->submittingTo(cp_route('product.update', $product));
   ```
2. On submit:
   ```php
   $values = PublishForm::make($blueprint)->submit($request->all());
   $product->update($values);
   ```

### B) Complex (Vue + Inertia)
3. Prepare blueprint + initial values/meta:
   ```php
   $fields = $blueprint->fields()->addValues($values)->preProcess();

   return Inertia::render('app::Products/Edit', [
     'blueprint' => $blueprint->toPublishArray(),
     'initialValues' => $fields->values(),
     'initialMeta' => $fields->meta(),
   ]);
   ```
4. Render with `PublishContainer`:
   ```vue
   <PublishContainer v-model="values" :blueprint="blueprint" :meta="meta" :errors="errors" />
   ```
5. Save via `@statamic/cms/save-pipeline`:
   - include `BeforeSaveHooks`, `Request`, `AfterSaveHooks` steps.
6. Server-side validation + processing:
   ```php
   $fields = $blueprint->fields()->addValues($request->all());
   $fields->validate();
   $values = $fields->process()->values();
   ```

### Blueprints
7. Get blueprint from YAML:
   ```php
   Blueprint::find('example');
   ```
8. Or create ad-hoc blueprint:
   ```php
   Blueprint::makeFromFields(['title' => ['type' => 'text']]);
   ```

## Pitfalls / gotchas
- Fieldtypes save “raw” values that often need augmentation when reading later.

## Sources
- https://statamic.dev/control-panel/publish-forms
