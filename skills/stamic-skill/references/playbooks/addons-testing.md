# Addons: Testing

**Summary:** Addons scaffold a PHPUnit suite automatically when created with `php please make:addon`. Tests run in a real Laravel app via Orchestra Testbench. Statamic provides `AddonTestCase` and helpers for dealing with the Stache during tests.

**When to use:**
- You’re publishing an addon or maintaining a complex one.
- You want CI confidence across PHP/Laravel versions.

## Steps
1. Scaffold by creating an addon:
   ```bash
   php please make:addon vendor/my-addon
   ```
   Creates `tests/`, `phpunit.xml`, and a `TestCase`.
2. Your addon's `TestCase` extends Statamic’s `AddonTestCase`.
3. Set config for tests when needed using `resolveApplicationConfiguration($app)`.
4. Write tests extending your addon's `TestCase`.
5. Handle Stache fixtures:
   - Stache items may be saved to `tests/__fixtures__`
   - to prevent saving to disk, use:
     ```php
     use Statamic\Testing\Concerns\PreventsSavingStacheItemsToDisk;
     ```
6. Run tests:
   ```bash
   ./vendor/bin/phpunit
   ```
   Use `--filter` to run specific tests.
7. CI: use GitHub Actions matrix for PHP/Laravel, install deps, run PHPUnit.

## Sources
- https://statamic.dev/addons/testing
