

---

## `scenarios/01-approle-auth-failure.md`

```markdown
# Scenario 01 – AppRole Authentication Failure

## Summary

An application using AppRole cannot authenticate to Vault. The login request fails with a permission or invalid credentials error.

---

## Symptoms

- AppRole login fails.
- `vault write auth/approle/login ...` returns an error.
- Application logs show “permission denied” or “invalid role_id/secret_id”.

## Error Output:

```bash
vault write auth/approle/login role_id="..." secret_id="..."
# Error writing data to auth/approle/login: invalid role ID or secret ID
```
**Reproduce the issue**

1. Ensure Vault is running and initialized:
This step assumes you ran the init--vault.sh script.
```bash
export VAULT_ADDR="http://127.0.0.1:8200"
export VAULT_TOKEN=$(grep 'Initial Root Token:' init.txt | awk '{print $4}')
```
2. Get the correct Role ID and Secret ID:

```bash
ROLE_ID=$(cat setup/roles/app-role-id.txt)
SECRET_ID=$(cat setup/roles/app-secret-id.txt)
```
3. Try logging in with a wrong Role ID:

```bash 
vault write auth/approle/login role_id="wrong-role-id" secret_id="$SECRET_ID"
```
4. Try logging in with a wrong Secret ID:

```bash
vault write auth/approle/login role_id="$ROLE_ID" secret_id="wrong-secret-id"
```
**Diagnose the Problem**

Key checks:
- Is the role_id correct?

- Is the secret_id correct and not expired?

- Does the role exist at auth/approle/role/app-role?

Commands:

```bash 
vault read auth/approle/role/app-role
vault read auth/approle/role/app-role/role-id
vault write -f auth/approle/role/app-role/secret-id
```

**Identify the Root Cause**

- The application (or user) is using an incorrect role_id or secret_id.

- In some cases, the secret_id may have expired based on secret_id_ttl.

**Apply the Fix**

1. Retrieve the correct Role ID:

```bash
vault read -format=json auth/approle/role/app-role/role-id \
  | jq -r '.data.role_id'
```

2. Generate a new Secret ID:

```bash
vault write -format=json -f auth/approle/role/app-role/secret-id \
  | jq -r '.data.secret_id'
```

3. Login with the correct values:

```bash
vault write auth/approle/login role_id="$ROLE_ID" secret_id="$SECRET_ID"
```

**Document Your Takeaways**

- AppRole auth depends on both a valid role_id and secret_id.

- secret_id can expire; TTLs matter.

- Always verify:

   - Role exists

   - Role ID matches

  - Secret ID is valid and not expired
