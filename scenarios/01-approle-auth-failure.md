
---

## Ticket # 456701  - AppRole Authentication Failure

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

- This step assumes you ran the **reset-lab.sh** script.  See steps to run script: [Lab Setup Script](../README.md#4-run-the-lab-setup-script)
- After running the reset script, save the output to use the **Root token** in later exercises.

2. Try logging in with a wrong Role ID:

Run:
```bash 
vault write auth/approle/login role_id="wrong-role-id" secret_id="$SECRET_ID"
```
3. Try logging in with a wrong Secret ID:

Run:
```bash
vault write auth/approle/login role_id="$ROLE_ID" secret_id="wrong-secret-id"
```

Result of running both commands is an error.

<img src="https://github.com/yyoung-50/vault-troubleshooting-lab/blob/main/screenshots/wrong-secret-id.png" width="500">

**Diagnose the Problem**

Key questions:
- Is the role_id correct?

- Is the secret_id correct and not expired?

- Does the role exist at auth/approle/role/app-role?

**Run these commands to diagnose:**

Run:
```bash 
vault read auth/approle/role/app-role
vault read auth/approle/role/app-role/role-id
vault write -f auth/approle/role/app-role/secret-id
```

The purpose of running these three commands are to:
- Inspect how the AppRole is configured
- Generate a role-id
- Generate a secret-id 

Use case for these commands are for manual inspection / debugging.

**Identify the Root Cause**

- The application (or user) is using an incorrect role_id or secret_id.

- In some cases, the secret_id may have expired based on the Secret-ID TTL (Time-To_live).

**Apply the Fix**

The fix is to generate an new Role-ID and Secret-ID

Run these commands below to generate a Role-ID and Secret-ID

**1. Retrieve the correct Role ID:**

```bash
vault read -format=json auth/approle/role/app-role/role-id \
  | jq -r '.data.role_id'
```

**2. Generate a new Secret ID:**

```bash
vault write -format=json -f auth/approle/role/app-role/secret-id \
  | jq -r '.data.secret_id'
```
Output from Steps 1 and 2 generate a new Role ID and Secret ID. The use case for returning output in JSON format is to use it in scripting/automation.

**3. Login with the correct values:**

Run the commands again with the correct Role-ID and Secret-ID generated in the previous commands.

```bash
vault write auth/approle/login role_id="$ROLE_ID" secret_id="$SECRET_ID"
```
- You can either export the role_id and secret_id as variables for reuse, or pass them directly into the login command. In real workflows, variables are cleaner and more efficient.

- For this exercise, you can pass them directly into the login command.

**Result:** Logging in with the correct Role ID and Secret ID resolves the issue.

**Key findings**  

- AppRole auth depends on both a valid role_id and secret_id.

- secret_id can expire; TTLs matter.

- Always verify:

   - Role exists

   - Role ID matches

  - Secret ID is valid and not expired

**Note:** After generating a new secret ID, you are able to sign on with the command below.

The following command authenticates to Vault using the AppRole method and returns a client token for API/CLI access, role-id and secret-id.

Run:
```bash
vault write auth/approle/login role_id="$ROLE_ID" secret_id="$SECRET_ID"
```

Result is successful authentication to Vault using AppRole authentication method

<img src="https://github.com/yyoung-50/vault-troubleshooting-lab/blob/main/screenshots/scenario01/correct-login-output.png" width="500">

---

After you complete a scenario run the setup script: [Lab Setup Script](../README.md#4-run-the-lab-setup-script)

You are now ready to go to the next scenario file: