# Widgets: Building a Widget

**Summary:** Widgets are dashboard components in the Statamic Control Panel. `php please make:widget` scaffolds a PHP widget class and a Vue component (or Blade view with `--blade`). The PHP class returns a `VueComponent::render()` plus props. Add widgets to the dashboard via `config/statamic/cp.php`.

**When to use:**
- You want custom dashboard panels (KPIs, status, recent activity, etc.).

## Steps
1. Generate:
   ```bash
   php please make:widget LocalWeather
   # or
   php please make:widget LocalWeather --blade
   ```
2. Implement the PHP widget class in `app/Widgets` (extends `Statamic\Widgets\Widget`).
   - return a Vue component + props:
     ```php
     use Statamic\Widgets\VueComponent;

     public function component()
     {
       return VueComponent::render('LocalWeather', ['message' => 'Hello World!']);
     }
     ```
3. Implement the Vue component in `resources/js/components/widgets`.
   - wrap content in `<Widget title="...">...</Widget>` from `@statamic/cms/ui`.
4. Configure dashboard widgets in `config/statamic/cp.php`:
   ```php
   'widgets' => [
     ['type' => 'local_weather', 'width' => 100],
   ],
   ```

## Pitfalls / gotchas
- The widget `type` in config is the widget handle (snake_cased).

## Sources
- https://statamic.dev/widgets/building-a-widget
