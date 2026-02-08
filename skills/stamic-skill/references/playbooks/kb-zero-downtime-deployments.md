# Knowledge Base: Zero Downtime Deployments

**Summary:** With multi-release deployments (Forge/Envoyer/Deployer), each release lives in a different path. Statamic may cache **absolute paths**, so sharing cache across releases can cause errors. Ensure cache isolation per release and handle Git Automation carefully.

**When to use:**
- You deploy with symlinked `current -> releases/<timestamp>`.
- You see production errors after deploy related to cache/stache paths.

## Steps
1. Understand the multi-release structure:
   - shared `.env` + shared `storage`
   - symlink swap updates `current` to new release.
2. **Do not share cache between releases**.
3. If using file cache:
   - option A: don’t share `storage` between releases (if feasible)
   - option B: move cache path outside shared storage by changing `config/cache.php`:
     ```php
     'stores' => [
       'file' => [
         'driver' => 'file',
         'path' => base_path('cache'),
       ],
     ]
     ```
4. If using Redis cache:
   - set a per-release cache prefix (e.g. based on release folder name):
     ```php
     'redis' => [
       'cache' => [
         'options' => [
           'prefix' => basename(base_path()).'_',
         ],
       ],
     ]
     ```
5. Git Automation with ZDD:
   - services like Envoyer/Deployer may deploy without `.git`.
   - init git + set remote during deploy if needed.
6. Prevent circular deployments:
   - append `[BOT]` to Statamic commit messages
   - cancel deploy when deploy message contains `[BOT]`.
7. If using Static Caching:
   - warm cache **after** switching `current` to the new release.
8. If committing form submissions:
   - store submissions outside shared storage by adding a `form-submissions` stache store + update `config/statamic/git.php` tracked paths.

## Pitfalls / gotchas
- Shared cache + absolute paths = intermittent breakage after deploy.

## Sources
- https://statamic.dev/knowledge-base/tips/zero-downtime-deployments
