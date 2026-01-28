# Modifiers: Building Modifiers

**Summary:** Custom modifiers are PHP classes extending `Statamic\Modifiers\Modifier` with an `index($value, $params, $context)` method. Create them with `php please make:modifier`. The modifier handle is snake_cased class name by default, with optional `$handle` and aliases.

**When to use:**
- You want reusable value transformations in Antlers.
- You want the same transformation available via Blade fluent modifiers.

## Steps
1. Generate a modifier:
   ```bash
   php please make:modifier Repeat
   ```
   Creates `app/Modifiers/Repeat.php` (auto-registered).
   - In an addon, register via the addon's provider (`$modifiers = [...]`) or conventions.
2. Implement the class:
   ```php
   namespace App\Modifiers;

   use Statamic\Modifiers\Modifier;

   class Repeat extends Modifier
   {
       public function index($value, $params, $context)
       {
           // return modified value
       }
   }
   ```
   - `$value`: the input
   - `$params`: array of modifier params
   - `$context`: contextual data at that location in template
3. Use it in templates:
   - Antlers: `{{ variable | repeat:2 }}`
   - Blade: `{{ Statamic::modify($variable)->repeat(2) }}`
4. Customize naming:
   - override handle with `protected static $handle = '...'`
   - add aliases with `protected static $aliases = ['duplicate']`

## Pitfalls / gotchas
- In Antlers, params may be variable references; your modifier can look up values in `$context`.

## Sources
- https://statamic.dev/extending/modifiers
