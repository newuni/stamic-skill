# Advanced Topics: Sending Email

**Summary:** In Statamic 6, the historical page at `/advanced-topics/sending-email` is not a reliable canonical reference. For production setups, treat email configuration and delivery as standard Laravel mail configuration plus Statamic UI/testing utilities.

**When to use:**
- You need to configure SMTP/API mail delivery for a Statamic project.
- You need a practical fallback when the older Statamic page is unavailable.

## Steps
1. Configure Laravel mail in `.env` (`MAIL_MAILER`, `MAIL_HOST`, `MAIL_PORT`, `MAIL_USERNAME`, `MAIL_PASSWORD`, `MAIL_FROM_*`).
2. Confirm project defaults in `config/mail.php` and environment-specific overrides.
3. Validate delivery with a test notification/mailable in your environment.
4. If available in your CP setup, use the email utility/testing flow to confirm runtime behavior.

## Pitfalls / gotchas
- The old `/advanced-topics/sending-email` route may appear in searches but can be incomplete or unavailable for 6.x.
- Mail settings that work locally may fail in production if provider credentials or TLS settings differ.

## Sources
- https://statamic.dev/advanced-topics/email
- https://statamic.dev/advanced-topics/sending-email
- https://laravel.com/docs/mail
