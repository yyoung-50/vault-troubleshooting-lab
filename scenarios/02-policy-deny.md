
---

## Ticket # 456702  - Permission Denied (Policy Issue)

```markdown
# Scenario 02 – Permission Denied (Policy Issue)

## Summary

A token cannot read a secret from `kv/app/config` even though the user believes it should have access.

---

## Symptoms

- `vault kv get kv/app/config` fails with permission denied.
- Application logs show 403 errors.
- User insists “the policy looks correct.”

## Error Output:

Running the command below outputs "permission denied"

```bash
vault kv get kv/app/config
# Error reading kv/app/config: permission denied

```

1. Ensure Vault is running and initialized:

- This step assumes you ran the **reset-lab.sh** script.  See steps to run script: [Lab Setup Script](../README.md#4-run-the-lab-setup-script)
- After running the reset script, save the output to use the **Root token** in later exercises.

Run the command to retrieve secrets:

Run:
```bash
vault kv get kv/app/config
```
- Command succeeded because the active token is the root token, which has full permissions.
- Command succeeded and retrieved secrets stored in Vault at that path:

Output of command:

**Key**      **Value**

api_key      super-secret-api-key

env          dev

---
**Reproduce the issue**

2. Create a token with a restricted policy, "default"(simulating a misconfigured policy):

Run:
```bash
vault token create -policy="default" -ttl=30m
```
Output of this command creates a token with a policy named "default".

- Save the token for the next step.

<img src="https://github.com/yyoung-50/vault-troubleshooting-lab/blob/main/screenshots/scenario01/token-policy-default.png" width="500">

3. Export the token from the output of the previous Step 2.

Run two commands:
```bash
export VAULT_TOKEN="token"
vault kv get kv/app/config
```

It should fail because the default policy attached to the token.  This policy does not allow; reading, writing secrets, creating tokens, managing auth methods.

<img src="https://github.com/yyoung-50/vault-troubleshooting-lab/blob/main/screenshots/scenario01/kv-get-error.png" width="500">

**Diagnose the Problem**

1. Find out which policies are attached to the token?

Run:
```bash
vault token lookup
```
This command shows the "default" policy which is restrictive, so the previous command failed.

<img src="https://github.com/yyoung-50/vault-troubleshooting-lab/blob/main/screenshots/scenario01/token-lookup-default.png" width="500">

2. Switch back to the Root token. (Token that was saved when you ran the "lab setup" script at the beginning of this exercise.)

The root token has sufficient permissions to inspect policies and create a new token.

Run:
```bash
export VAULT_TOKEN=<root_token>
```

3. Check the existing "app-policy" has the correct permissions.

Run:
```bash
vault policy read app-policy
```
The "app-policy" allows "read" and "list" so will be able to run the **vault kv get kv/app/config** command

![Vault Login Output](https://raw.githubusercontent.com/yyoung-50/vault-troubleshooting-lab/main/screenshots/scenario01/vault-app-policy.png) 

**Identify the Root Cause**

- The command "vault kv get kv/app/config" failed because the token did not have sufficient permissions.

- The token does not have the app-policy attached as confirmed by the output of the command "vault token lookup"

- Or the policy path is wrong (e.g., kv/app/* instead of kv/data/app/* for KV v2).

**Apply the Fix**

The fix is to attach a policy with more permissions.

1. Attach a new policy to the token called "app-policy":

Run:
```bash
vault token create -policy="app-policy" -ttl=30m
```
This command creates a new token and attaches the "app-policy", the "default" policy and sets the TTL to 30 minutes.

2. Export the token from the output of the previous command. 

Run:
```bash
export VAULT_TOKEN=<token>
```

After exporting the Token with the new **app-policy**, you will be able to run the command.

3. Run:

```bash
vault kv get kv/app/config
```
Command succeeds because token has correct policy applied

![Vault Login Output](https://raw.githubusercontent.com/yyoung-50/vault-troubleshooting-lab/main/screenshots/scenario01/export-kv-get.png)

**Key findings**

- Policy issues are one of the most common Vault problems.

- Always verify:

  - Which policies are attached to the token

  - Whether the policy paths match the engine type (KV v1 vs KV v2)

---

After you complete a scenario run the setup script: [Lab Setup Script](../README.md#4-run-the-lab-setup-script)

You are now ready to go to the next scenario file: