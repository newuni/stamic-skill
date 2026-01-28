# Frontend: Forms

**Summary:** Statamic Forms provide end-to-end form handling: define a form (settings), define a blueprint (fields + validation), render the form with tags (dynamic rendering is available), store submissions, export submissions, and optionally send emails/attachments and handle uploads.

**When to use:**
- Building contact/newsletter/job application forms.
- Handling submissions + exporting.
- Sending notifications on submission.

## Steps
1. Create a form:
   - CP: `/cp/forms` → Create Form
   - or create YAML in `resources/forms/<handle>.yaml`
2. Define the form blueprint:
   - `resources/blueprints/forms/<handle>.yaml`
   - add fields + validation rules
   - avoid reserved handle `message` if using email feature
3. Render a form in templates:
   - use `{{ form:<handle> }}` / `{{ form:create }}` patterns
   - handle success/errors
   - loop `{{ fields }}` to render dynamic field HTML
   - include honeypot field (custom name possible)
4. View and export submissions in CP.
5. Configure exporters in `config/statamic/forms.php` (csv/json or custom).
6. Configure email notifications in the form config:
   - support multiple emails per submission
   - dynamic `to`, `reply_to`, and `subject` using variables
   - enable `attachments: true` for assets uploads
   - optional Laravel markdown mailables
7. Handle uploads:
   - use `assets` field to store uploads in a container
   - use `files` field to attach and delete after email
8. Static caching:
   - exclude the page from caching or wrap the form in `{{ nocache }}` so success/errors show after submit.
9. AJAX:
   - include `_token` and `_params`
   - set `X-Requested-With: XMLHttpRequest`
10. Optional: Precognition for live validation (Alpine example).

## Pitfalls / gotchas
- Static caching will hide post-submit states unless you use `nocache` or exclusions.
- Uploadable extensions are restricted by Statamic assets config.

## Sources
- https://statamic.dev/frontend/forms
