# Advanced Topics: Sites API (statamic.com)

**Summary:** Statamic provides an API on statamic.com to manage your Sites in your Statamic account (primarily useful for the Platform Plan). Authenticate with a bearer token and call REST endpoints to list/create/delete sites.

**When to use:**
- Automating site provisioning in statamic.com.
- Managing site keys/domains programmatically.

## Steps
1. Create an API token in your statamic.com account.
2. Send requests with headers:
   - `Authorization: Bearer <token>`
   - `Accept: application/json`
3. Using Laravel HTTP client:
   ```php
   Http::acceptJson()
     ->withToken($token)
     ->post('https://statamic.com/api/v1/sites', $payload);
   ```
4. Endpoints:
   - List: `GET https://statamic.com/api/v1/sites`
   - Create: `POST https://statamic.com/api/v1/sites` (params: `name` required, `domain` optional)
   - Delete: `DELETE https://statamic.com/api/v1/sites/{site-key}`

## Pitfalls / gotchas
- Treat tokens as secrets; don’t commit them.

## Sources
- https://statamic.dev/advanced-topics/sites-api
