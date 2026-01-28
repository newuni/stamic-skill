# Control Panel: Users

**Summary:** Users are accounts that can access the Control Panel and/or front-end areas. Access is governed by roles/permissions. Users can be stored in files by default but can be moved to a database/custom storage. Statamic v6 includes modern auth options like 2FA and passkeys.

**When to use:**
- Creating/administering users and roles.
- Designing authoring permissions and multi-site access.
- Implementing 2FA/passkeys or custom auth flows.

## Steps
1. Create a user:
   - CLI: `php please make:user`
   - CP: create user (optionally send invitation)
   - File: create users by hand (password will be encrypted when detected)
2. Customize user fields by editing the shared user blueprint.
3. Define permissions via roles:
   - roles stored in `resources/users/roles.yaml`
   - user groups stored in `resources/users/groups.yaml`
4. Assign roles to users (or to user groups) rather than micromanaging permissions per user.
5. In multi-site, ensure users also have the relevant `access {site} site` permissions.
6. Configure advanced features as needed:
   - password validation via Laravel `Password::defaults(...)`
   - impersonation (and its permission)
   - 2FA enforcement by role
   - passkeys via WebAuthn config

## Pitfalls / gotchas
- Author permissions only work if your entry blueprint includes an **author** field.
- 2FA secrets/recovery codes depend on `APP_KEY`; sharing users across environments with different `APP_KEY` can break 2FA.

## Sources
- https://statamic.dev/control-panel/users
