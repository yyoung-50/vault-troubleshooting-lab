
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
 
```bash
vault kv get kv/app/config
# Error reading kv/app/config: permission denied

```
1. Run the command:

```bash
vault kv get kv/app/config
```
Command will succeed and retrieve a secrets stored in Vault at that path:

Key        Value
---        -----
api_key    super-secret-api-key
env        dev

**Reproduce the issue**

2. Create a token with a restricted policy, "default"(simulating a misconfigured policy):

```bash
vault token create -policy="default" -ttl=30m
```
Output of this command creates a token with a policy named "default".

<img src="https://github.com/yyoung-50/vault-troubleshooting-lab/blob/main/screenshots/scenario01/token-policy-default.png" width="500">


3. Export the token from the output of the command in Step 1 

```bash
export VAULT_TOKEN="token"
```

4. Run the command below with the restricted policy

```bash
vault kv get kv/app/config
```
It should fail because the default policy which does not allow; reading, writing secrets, creating tokens, managing auth methods.

**Diagnose the Problem**

1. Find out which policies are attached to the token?

```bash
vault token lookup
```
This command shows the "default" policy which is restrictive, so command fails.

(screen here)

2. Run command below to see what the app-policy allows?

```bash
vault policy read app-policy
```
The "app-policy" allows "read" and "list" so will be able to run the **vault kv get kv/app/config** command

![Vault Login Output](https://raw.githubusercontent.com/yyoung-50/vault-troubleshooting-lab/main/screenshots/scenario01/vault-app-policy.png)

3. Is the token actually using app-policy?

**Identify the Root Cause**

- The token does not have the app-policy attached, and this was confirmed by the output of the command "vault token lookup"

- Or the policy path is wrong (e.g., kv/app/* instead of kv/data/app/* for KV v2).

**Apply the Fix**

1. Create a new policy called "app-policy":

```bash
vault token create -policy="app-policy" -ttl=30m
```
This command creates a new token and attaches the "app-policy", the "default" policy and sets the TTL to 30 minutes.

2. Export the Token from the output of the command. 

```bash
export VAULT_TOKEN=<token>
```

After exporting the Token with the new **app-policy**, you will be able to run the command.

3. Run both commands:

```bash
export VAULT_TOKEN=<root_token> 
vault kv get kv/app/config
```
Commands succeeds because token has correct policy applied

![Vault Login Output](https://raw.githubusercontent.com/yyoung-50/vault-troubleshooting-lab/main/screenshots/scenario01/export-kv-get.png)

**Key findings**

- Policy issues are one of the most common Vault problems.

- Always verify:

  - Which policies are attached to the token

  - Whether the policy paths match the engine type (KV v1 vs KV v2)

---

After you complete a scenario run the setup script: [Lab Setup Script](../README.md#4-run-the-lab-setup-script)

You are now ready to go to the next scenario file: