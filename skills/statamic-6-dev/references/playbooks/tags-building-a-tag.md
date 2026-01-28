# Tags: Building a Tag

**Summary:** A tag is a PHP method callable from Antlers (`{{ foo:bar }}`) or Blade components (`<s:foo:bar />`). Create a Tags class (multiple methods per handle), access parameters and context via helper collections, and return strings/booleans for single tags or arrays for tag pairs. Use wildcards for dynamic methods (e.g. `collection:blog`).

**When to use:**
- You want a reusable template-level feature (like mini controllers).
- You need custom data fetching/manipulation in Antlers/Blade without writing controllers everywhere.

## Steps
1. Generate a tag class:
   ```bash
   php please make:tag Foo
   ```
   Creates `app/Tags/Foo.php` (auto-registered).
   - In an addon, register via the addon's service provider (`$tags = [...]`) or conventions.
2. Create your class extending `Statamic\Tags\Tags`.
   - Each **public method** becomes a tag method (snake_case in templates).
   - `index()` is used when no method is specified (e.g. `{{ my_tags }}`).
3. Understand template mapping:
   - `{{ acme:foo_bar }}` → `fooBar()`
   - `{{ my_tags }}` → `index()`
4. Use tag pairs when you need inner content:
   - content is available via `$this->content`
   - determine usage via `$this->isPair`
5. Wildcard methods:
   - implement `wildcard($tag)` to catch dynamic methods (`tag:*`)
   - prefer wildcard over `__call` (has extra Statamic “smarts”)
6. Parameters:
   - available via `$this->params`
   - supports typed helpers: `get`, `bool`, `int`, `float`, `explode`
   - `:param="var"` resolves from context.
7. Context:
   - available via `$this->context`
   - use `value()` for augmented values and `raw()` for un-augmented values when context items are `Value` objects.
8. Return values:
   - single tags: return string/boolean
   - tag pairs: return array/collection (new context for inside the pair)
   - returning an empty array in Antlers yields `no_results`.
9. Blade considerations:
   - for pair empty results, can use `<s:no_results>` in simple cases.
   - if your tag supports `as="..."`, use `$this->aliasedResult(...)` to support Blade aliasing.
   - don’t assume tag content is Antlers; if you parse content, use `$this->parse()`.
   - you can branch behavior using `$this->isAntlersBladeComponent()`.

## Pitfalls / gotchas
- Parent context is not automatically available inside a pair result; pass it through explicitly if needed.
- If you conditionally include output variables, consider always including them (with defaults) for Blade “isset” ergonomics.

## Sources
- https://statamic.dev/tags/building-a-tag
