# Advanced Topics: Caching (overview)

**Summary:** Statamic performance relies on multiple caching layers:
- **Stache** (file-backed “database” built into Laravel cache)
- **Application cache** (Laravel Cache for expensive operations, e.g. Glide transforms)
- **View fragments** (template-level caching via the `cache` tag)
- **Static caching** (HTML caching, from “half measure” to “full measure”)

**When to use:**
- Diagnosing performance issues.
- Choosing the right caching layer for the problem.

## Steps
1. Understand the Stache:
   - it’s **ephemeral** and can be rebuilt without data loss.
   - manage via CLI:
     ```bash
     php please stache:clear
     php please stache:warm
     php please stache:refresh
     ```
2. Use Laravel’s application cache for general caching:
   - clear with:
     ```bash
     php artisan cache:clear
     ```
   - note: clearing app cache also clears the Stache (since it’s stored inside it).
3. Cache expensive template fragments with the `cache` tag:
   ```antlers
   {{ cache for="1 hour" }}
     ...
   {{ /cache }}
   ```
4. If you need maximum speed, enable Static Caching and choose:
   - **application driver** (“half measure”) for easy wins
   - **file driver** (“full measure”) for web-server served HTML
5. If you need true “no PHP” runtime, consider Statamic SSG instead of static caching.

## Pitfalls / gotchas
- You **cannot disable the Stache**; it’s core architecture.
- Static caching can break dynamic features (forms, protection, randomization) unless designed carefully (see `nocache`).

## Sources
- https://statamic.dev/advanced-topics/caching
