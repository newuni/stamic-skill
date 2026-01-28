# Frontend: Forms

**Summary:** Statamic forms are defined via a form config + a blueprint, store submissions, can email notifications, support file uploads, honeypot spam prevention, AJAX, and Laravel Precognition integration.

**When to use:**
- Contact forms, registrations, multi-step-ish custom flows.

## Steps
1. Create a form in CP (`/cp/forms`) or YAML under `resources/forms/{handle}.yaml`.
2. Define fields + validation in `resources/blueprints/forms/{handle}.yaml`.
   - avoid using `message` handle if you use form email config (Laravel reserved in that context).
3. Render the form with tags:
   ```antlers
   {{ form:contact }}
     {{ if success }}{{ success }}{{ /if }}
     {{ if errors }}{{ errors }}{{ value }}{{ /errors }}{{ /if }}
     {{ fields }}
       <label>{{ display }}</label>
       {{ field }}
       {{ if error }}{{ error }}{{ /if }}
     {{ /fields }}
     <input type="text" class="hidden" name="{{ honeypot ?? 'honeypot' }}">
     <button type="submit">Submit</button>
   {{ /form:contact }}
   ```
4. View submissions in CP; render submissions using `form:submissions`.
5. Export submissions (CSV/JSON) via exporters in `config/statamic/forms.php`.
6. Emails:
   - add `email:` blocks to the form config; can use auto email or custom `html`/`text` views.
   - can set to/reply_to/subject dynamically using Antlers variables.
   - attachments: `attachments: true` to attach uploaded assets.
7. File uploads:
   - use `assets` fieldtype to store uploads as assets (container required).
   - use `files` fieldtype for ephemeral uploads (attach then delete).
   - for multiple files, use `name="files[]"` + `multiple`.
8. Honeypot:
   - add a hidden field; configure custom honeypot name in form config if desired.
9. AJAX:
   - include `_token` and `_params`; set `X-Requested-With: XMLHttpRequest`.
10. Static caching:
   - wrap forms in `nocache` or exclude page from static cache.
11. Precognition:
   - supported with `js="alpine_precognition"` and Alpine examples.

## Pitfalls / gotchas
- If a page is statically cached, you must use `nocache` around the form or exclude that URL.

## Sources
- https://statamic.dev/frontend/forms
