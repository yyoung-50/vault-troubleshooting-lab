<p align="center">
  <img src="https://img.shields.io/badge/Status-Work_in_Progress-yellow" width="220">
</p>

### **This project is a work in progress. I’m building it step by step and will be completed soon.**




## Vault Troubleshooting Lab

## Overview

This project is a **Vault Troubleshooting Lab** designed to simulate realistic support scenarios for HashiCorp Vault.

Instead of just “running Vault,” this lab focuses on:
- Reproducing common Vault issues
- Diagnosing failures
- Reading logs and error messages
- Identifying root cause
- Documenting clear fixes

It’s built to mirror the mindset and workflow of a **Vault Support Engineer**.

---

## Goals

This lab demonstrates:

- Understanding of Vault core concepts (auth methods, policies, secrets engines, tokens)
- Ability to troubleshoot common issues
- Ability to document problems and resolutions clearly
- Familiarity with CLI workflows and logs
- A support-focused approach to Vault, not just installation

---

## Architecture

- **Vault** running in Docker using `docker-compose`
- **File storage backend**
- **KV v2** secrets engine at path `kv/`
- **AppRole** auth method enabled
- **Sample policies** for app and admin
- **Scenarios** that intentionally break things

---
## Project Folder Structure
```text
vault-troubleshooting-lab/
│
├── README.md
├── docker-compose.yml
├── setup/
│   ├── init-vault.sh
│   ├── policies/
│   │   ├── app-policy.hcl
│   │   └── admin-policy.hcl
│   └── roles/
│       └── approle-role.json
└── scenarios/
    ├── 01-approle-auth-failure.md
    ├── 02-policy-deny.md
    ├── 03-token-expired.md
    ├── 04-kvv2-path-issue.md
    ├── 05-transit-decrypt-failure.md
    ├── 06-seal-behavior.md
    └── 07-wrong-mount-path.md
|
└── docs/
    ├── environment-setup.md
    ├── full-project-blueprint.md
    ├── vault-concepts.md
    └── 
```
**Note:** when running commands, make sure you are in the project folder called **vault-troubleshooting-lab**
```

🧰 Prerequisites

This lab assumes the following tools are already installed:

- Docker & Docker Compose - (This lab requires **Docker Desktop**) see 👉 [Environment Setup](docs/environment-setup.md)

- A code editor (VS Code recommended) - see 👉 https://code.visualstudio.com/docs/setup/setup-overview

- Bash or a Unix‑like shell

- Basic familiarity with Vault CLI commands (Vault CLI)
- **jq** installed (https://stedolan.github.io/jq/download/)

**About the `jq` tool**
- **jq** is a JSON parsing tool used to read Vault's JSON output.
If you run "jq ." and get, "bash:jq: command not found", you need to install it.

**To install **jq**:

1. download the jq-win64.exe
2. Rename it from jq-wind64.exe to jq.exe
3. Move it to C:\Windows\System32
4. Close and reopen VS Code
5. Verify by running command "jq --version" 
```
## How to Run the Lab
1. Start Vault
```
docker-compose up -d
```
2. Initialize and Configure Vault
```
chmod +x setup/init-vault.sh
./setup/init-vault.sh
```
3. Export Vault Address
```
export VAULT_ADDR="http://127.0.0.1:8200" (This must be set before running Vault CLI commands.)
```
Running the script called **init-vault.sh** will setup the following: 

- Initialize Vault
- Unseal Vault
- Enable KV v2 at kv/
- Enable AppRole auth
- Create app-policy and admin-policy
- Create app-role
- Store a sample secret at kv/app/config

The following files will be created:

- Unseal key and root token in init.txt
- Role ID in setup/roles/app-role-id.txt
- Secret ID in setup/roles/app-secret-id.txt

**Working with the Troubleshooting Scenarios**

Each file in scenarios directory is a mini support ticket with:

- Summary
- Symptoms
- Commands
- Logs / error messages
- Root cause
- Fix
- Takeaways

You can work through them one by one to practice:

- Reproducing the issue
- Observing the error
- Diagnosing the cause
- Applying the fix
- Explaining what happened

**Resetting the Lab**

To reset the lab and start over run the following commands:

```hcl
docker-compose down -v  
rm -rf data/* init.txt setup/roles/app-role-id.txt setup/roles/app-secret-id.txt
docker-compose up -d
vault status
```
**Expect the output to be:**
```
Initialized: false
Sealed: true
```
- At this point Vault will not be **initialized** and it will be **sealed**.

- Vault is only initialized once, so to start over you need to delete the storage backend directory because that's where the initialization information is stored.

Run the script to configure Vault and export the VAULT_ADDR environment variable
```
./setup/init-vault.sh
export VAULT_ADDR="http://127.0.0.1:8200"
```
Verify Vault is initialized and not sealed
```
vault status
```
**Expect the output to be:**
```
Initialized: true
Sealed: false
```
```
**Verify the script worked** - see 👉 [Verify the Script](docs/Verifying-vault-script)
```

## Scenarios Included

```
1. AppRole Authentication Failure
2. Permission Denied (Policy Issue)
3. Token Expired (TTL Issue)
4. KV v2 Path Confusion
5. Transit Decrypt Failure
6. Vault Seal Behavior
7. Wrong Mount Path
```
Each scenario is designed to align with real-world Vault support cases.

Code

---

Now the scenarios. Each is written like a mini ticket.

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

Example CLI error:

```bash
vault write auth/approle/login role_id="..." secret_id="..."
# Error writing data to auth/approle/login: invalid role ID or secret ID
Reproduction Steps
Ensure Vault is running and initialized:

bash
export VAULT_ADDR="http://127.0.0.1:8200"
export VAULT_TOKEN=$(grep 'Initial Root Token:' init.txt | awk '{print $4}')
Get the correct Role ID and Secret ID:

bash
ROLE_ID=$(cat setup/roles/app-role-id.txt)
SECRET_ID=$(cat setup/roles/app-secret-id.txt)
Try logging in with a wrong Role ID:

bash
vault write auth/approle/login role_id="wrong-role-id" secret_id="$SECRET_ID"
Try logging in with a wrong Secret ID:

bash
vault write auth/approle/login role_id="$ROLE_ID" secret_id="wrong-secret-id"
Diagnosis
Key checks:

Is the role_id correct?

Is the secret_id correct and not expired?

Does the role exist at auth/approle/role/app-role?

Commands:

bash
vault read auth/approle/role/app-role
vault read auth/approle/role/app-role/role-id
vault write -f auth/approle/role/app-role/secret-id
Root Cause
The application (or user) is using an incorrect role_id or secret_id.

In some cases, the secret_id may have expired based on secret_id_ttl.

Fix
Retrieve the correct Role ID:

bash
vault read -format=json auth/approle/role/app-role/role-id \
  | jq -r '.data.role_id'
Generate a new Secret ID:

bash
vault write -format=json -f auth/approle/role/app-role/secret-id \
  | jq -r '.data.secret_id'
Login with the correct values:

bash
vault write auth/approle/login role_id="$ROLE_ID" secret_id="$SECRET_ID"
Takeaways
AppRole auth depends on both a valid role_id and secret_id.

secret_id can expire; TTLs matter.

Support engineers should always verify:

Role exists

Role ID matches

Secret ID is valid and not expired

Code

---

## `scenarios/02-policy-deny.md`

```markdown
# Scenario 02 – Permission Denied (Policy Issue)

## Summary

A token cannot read a secret from `kv/app/config` even though the user believes it should have access.

---

## Symptoms

- `vault kv get kv/app/config` fails with permission denied.
- Application logs show 403 errors.
- User insists “the policy looks correct.”

Example:

```bash
vault kv get kv/app/config
# Error reading kv/app/config: permission denied
Reproduction Steps
Create a token with a restricted policy (simulate a misconfigured policy):

bash
vault token create -policy="default" -ttl=30m
Use that token:

bash
export VAULT_TOKEN="<new-token>"
vault kv get kv/app/config
Diagnosis
Check:

Which policies are attached to the token?

bash
vault token lookup
What does the app-policy allow?

bash
vault policy read app-policy
Is the token actually using app-policy?

Root Cause
The token does not have the app-policy attached.

Or the policy path is wrong (e.g., kv/app/* instead of kv/data/app/* for KV v2).

Fix
Create a token with the correct policy:

bash
vault token create -policy="app-policy" -ttl=30m
Use that token:

bash
export VAULT_TOKEN="<new-app-policy-token>"
vault kv get kv/app/config
Takeaways
Policy issues are one of the most common Vault problems.

Always verify:

Which policies are attached to the token

Whether the policy paths match the engine type (KV v1 vs KV v2)

Code

---

## `scenarios/03-token-expired.md`

```markdown
# Scenario 03 – Token Expired (TTL Issue)

## Summary

An application suddenly loses access to Vault. It worked earlier, but now all requests fail.

---

## Symptoms

- Requests that previously worked now fail.
- Errors mention “expired token” or “permission denied.”
- `vault token lookup` shows `expired_time` in the past.

---

## Reproduction Steps

1. Create a short-lived token:

```bash
vault token create -policy="app-policy" -ttl=30s
Use the token:

bash
export VAULT_TOKEN="<short-lived-token>"
vault kv get kv/app/config
Wait 45–60 seconds, then try again:

bash
vault kv get kv/app/config
Diagnosis
Check the token details:

bash
vault token lookup "<short-lived-token>"
Look at:

ttl

expire_time

renewable

Root Cause
Token TTL was too short for the application’s usage pattern.

Token was not renewed before expiration.

Fix
Create a longer-lived token (for testing):

bash
vault token create -policy="app-policy" -ttl=1h
For production:

Use renewable tokens.

Implement token renewal in the application.

Takeaways
Token TTL and renewal are critical for stable access.

Support engineers should:

Check token TTL and renewable flag.

Educate users on renewal patterns.

Code

---

## `scenarios/04-kvv2-path-issue.md`

```markdown
# Scenario 04 – KV v2 Path Confusion

## Summary

A user cannot read a secret from KV v2. They get “no value found at path” even though the secret exists.

---

## Symptoms

- `vault kv get kv/app/config` fails.
- User insists “I wrote the secret already.”
- Error: `no value found at kv/app/config`.

---

## Reproduction Steps

1. Ensure KV v2 is enabled at `kv/` (done in setup).

2. Write a secret:

```bash
vault kv put kv/app/config api_key="super-secret-api-key"
Try to read using the wrong path (API style):

bash
vault read kv/app/config
Diagnosis
Understand KV v2 paths:

CLI vault kv get kv/app/config → handles /data/ internally.

API path is kv/data/app/config.

Check:

bash
vault kv get kv/app/config
vault read kv/data/app/config
Root Cause
Confusion between KV v1 and KV v2 paths.

Using kv/app/config instead of kv/data/app/config with the raw API.

Fix
Use vault kv get kv/app/config with the CLI.

Use kv/data/app/config for API calls.

Takeaways
KV v2 introduces a /data/ and /metadata/ path structure.

Many real-world tickets are caused by this exact confusion.

Code

---

## `scenarios/05-transit-decrypt-failure.md`

```markdown
# Scenario 05 – Transit Decrypt Failure

## Summary

An application can encrypt data using the Transit engine but fails to decrypt it.

---

## Symptoms

- `vault write transit/decrypt/...` fails.
- Error mentions invalid ciphertext or key version.
- Encryption appears to work fine.

---

## Reproduction Steps

1. Enable Transit:

```bash
vault secrets enable transit
Create a key:

bash
vault write -f transit/keys/app-key
Encrypt some data:

bash
vault write -format=json transit/encrypt/app-key plaintext=$(echo -n "hello" | base64) \
  | jq -r '.data.ciphertext' > ciphertext.txt
Corrupt the ciphertext:

bash
sed -i '' 's/./X/' ciphertext.txt  # macOS example; or edit manually
Try to decrypt:

bash
vault write transit/decrypt/app-key ciphertext="$(cat ciphertext.txt)"
Diagnosis
Check:

Is the ciphertext intact?

Was the key rotated?

Is the correct key name used?

Root Cause
Ciphertext was corrupted or modified.

Or wrong key name / version used.

Fix
Use the original, unmodified ciphertext.

Ensure the correct key name and version.

Takeaways
Transit is sensitive to ciphertext integrity.

Support engineers should:

Ask for the exact ciphertext used.

Verify key name and rotation status.

Code

---

## `scenarios/06-seal-behavior.md`

```markdown
# Scenario 06 – Vault Seal Behavior

## Summary

Vault appears “down” or “unavailable” after a restart. Users cannot access secrets.

---

## Symptoms

- CLI commands fail with `Vault is sealed`.
- UI shows Vault as sealed.
- Apps cannot authenticate.

---

## Reproduction Steps

1. Restart the container:

```bash
docker-compose restart
Try a command:

bash
export VAULT_ADDR="http://127.0.0.1:8200"
vault status
Diagnosis
Check status:

bash
vault status
Look for:

Sealed: true

Key Shares

Key Threshold

Root Cause
Vault was restarted and is sealed by design.

Unseal key was not applied.

Fix
Get the unseal key from init.txt:

bash
UNSEAL_KEY=$(grep 'Unseal Key 1:' init.txt | awk '{print $4}')
vault operator unseal "$UNSEAL_KEY"
Verify:

bash
vault status
Takeaways
Sealing is a security feature, not a bug.

Support engineers should:

Recognize sealed state quickly.

Guide users through unseal process.

Code

---

## `scenarios/07-wrong-mount-path.md`

```markdown
# Scenario 07 – Wrong Mount Path

## Summary

A user gets “no handler for route” or similar errors when trying to access a secrets engine.

---

## Symptoms

- `no handler for route` errors.
- User is calling `secret/...` when engine is mounted at `kv/`.
- Confusion about mount paths.

---

## Reproduction Steps

1. Confirm KV is mounted at `kv/`:

```bash
vault secrets list
Try to read using the wrong path:

bash
vault kv get secret/app/config
Diagnosis
Check:

Where is the engine actually mounted?

Are they using the correct mount path?

Root Cause
User assumes default path (secret/) but engine is mounted at kv/.

Fix
Use the correct mount path:

bash
vault kv get kv/app/config
Takeaways
Mount paths are configurable and must be respected.

Support engineers should:

Ask for vault secrets list output.

Confirm the exact path being used.












