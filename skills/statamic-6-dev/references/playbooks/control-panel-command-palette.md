# Control Panel: Command Palette

**Summary:** The Command Palette (⌘K / Ctrl+K) lets you navigate, search content, access recent pages, run contextual actions, and jump to preferences without leaving the keyboard. It auto-includes CP nav items and can be extended.

**When to use:**
- Improving CP navigation speed for editors/devs.
- Adding custom quick links/actions for your project/addons.

## Steps
1. Use ⌘K / Ctrl+K to open the palette.
2. Extend it automatically by extending CP navigation (nav items appear in the palette).
3. Add custom items in PHP:
   ```php
   use Statamic\Facades\CommandPalette;

   CommandPalette::add(
     text: 'Staff Calendar',
     url: '/custom-laravel-route',
     icon: 'calendar',
   );
   ```
4. Add advanced links (breadcrumbs text array, openNewTab, trackRecent flags).
5. Add/extend items in JavaScript via `Statamic.$commandPalette.add({...})`.
   - use `when` and `action` for contextual actions
   - raise visibility by setting category to Actions and/or `prioritize: true`
6. For simple template wiring, use the `<ui-command-palette-item>` Vue component.

## Pitfalls / gotchas
- JS-added link items default `trackRecent` to false (can override).

## Sources
- https://statamic.dev/control-panel/command-palette
