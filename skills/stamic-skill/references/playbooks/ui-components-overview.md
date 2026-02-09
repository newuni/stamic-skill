# UI Components: Overview

**Summary:** Statamic provides a library of UI components used across the Control Panel (buttons, inputs, icons, panels, widgets, etc.). When building CP extensions (addons, fieldtypes, utilities, widgets), prefer these components for consistent styling/behavior.

**Where to look:**
- Statamic UI Storybook (authoritative reference): https://ui.statamic.dev

## Steps
1. Identify the CP UI surface you are extending (fieldtype, widget, utility, page fragment).
2. Find the matching base component pattern in Storybook (`ui.statamic.dev`) before implementing custom markup.
3. Use the Statamic UI component primitives from `@statamic/cms/ui` in your Vue components.
4. Validate visual consistency in the CP context where the component is used.

## Pitfalls / gotchas
- Skipping Storybook review usually leads to inconsistent spacing/behavior in CP UI.
- Recreating controls manually increases maintenance cost versus using shared UI primitives.

## Sources
- https://ui.statamic.dev
