# Frontend: Customizing Markdown

**Summary:** Statamic parses Markdown using the `Statamic\Facades\Markdown` facade, powered by `league/commonmark` (CommonMark 2.4 in Statamic 5+). You can customize parsing via `config/statamic/markdown.php`, add CommonMark extensions, register custom renderers, and define additional named parsers for different contexts (e.g. “safe”, “special”, “docs”).

**When to use:**
- You want features like autolinking, TOCs, heading permalinks, or custom syntax.
- You need safer Markdown (escape HTML) for untrusted user content.
- You want different Markdown behaviors per field/context.

## Steps
1. Basic parsing in PHP:
   ```php
   use Statamic\Facades\Markdown;

   Markdown::parse('# Hello World!');
   ```
2. Configure the default parser:
   - Edit `config/statamic/markdown.php` and set a CommonMark config array under the `default` config.
   - Only include the options you want to override.
3. Add extensions in a service provider (e.g. `AppServiceProvider::boot()`):
   - Use `Markdown::addExtension(...)` or `Markdown::addExtensions(...)` to register one or many extensions.
4. Add custom renderers for node types:
   - Use `Markdown::addRenderer(...)` / `addRenderers(...)` and map a node class (e.g. `Link::class`) to your renderer.
   - Optionally set renderer priority to resolve conflicts.
5. Use helper methods for common behaviors:
   - `withAutoLinks()`
   - `withSmartPunctuation()`
   - `withMarkupEscaping()` (escape HTML)
   - `withAutoLineBreaks()`
   - `withStatamicDefaults()`
   - `newInstance($config)` to derive a new parser from an existing one.
6. Create and reuse custom named parsers:
   ```php
   Markdown::extend('special', function ($parser) {
       return $parser
           ->withStatamicDefaults()
           ->addExtensions(/* ... */);
   });

   Markdown::parser('special')->parse('# Heading');
   ```
7. Use custom parsers in templates/fieldtypes:
   - In Antlers: `{{ text | markdown:special }}`
   - In a Markdown fieldtype blueprint: set `parser: special` so augmentation uses it automatically.

## Pitfalls / gotchas
- **Version mismatch:** Statamic 5+ uses CommonMark 2.4; older blog posts/packages may target CommonMark 1.x/2.2.
- **Security:** if content is untrusted, enable markup escaping (or avoid allowing HTML) to reduce XSS risk.
- **Different contexts:** consider multiple parsers instead of one global configuration when needs vary (e.g. marketing pages vs. user comments).

## Sources
- https://statamic.dev/frontend/markdown
- https://commonmark.thephpleague.com/2.4/
