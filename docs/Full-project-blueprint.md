⭐ Vault Troubleshooting Lab — Full Project Blueprint
This is the complete structure of your project.


📁 1. Project Folder Structure
Code
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
│
└── scenarios/
    ├── 01-approle-auth-failure.md
    ├── 02-policy-deny.md
    ├── 03-token-expired.md
    ├── 04-kvv2-path-issue.md
    ├── 05-transit-decrypt-failure.md
    ├── 06-seal-behavior.md
    └── 07-wrong-mount-path.md
This structure mirrors how real support teams organize internal labs.

🐳 2. docker-compose.yml (Local Vault Environment)
This gives you a clean, reproducible Vault environment:

Vault server

Dev mode OFF (so you get real unseal keys + root token)

File storage backend

Exposed logs

You’ll be able to break things safely.

Code
version: "3.8"

services:
  vault:
    image: hashicorp/vault:1.17
    container_name: vault-lab
    ports:
      - "8200:8200"
    environment:
      VAULT_LOCAL_CONFIG: |
        ui = true
        listener "tcp" {
          address     = "0.0.0.0:8200"
          tls_disable = 1
        }
        storage "file" {
          path = "/vault/data"
        }
    cap_add:
      - IPC_LOCK
    volumes:
      - ./data:/vault/data

🔧 3. setup/init-vault.sh (Initialization Script)
This script:

initializes Vault

unseals it

enables KV v2

enables AppRole

loads policies

creates a role

This gives you a consistent baseline before breaking things.

Code
#!/bin/bash

export VAULT_ADDR="http://127.0.0.1:8200"

vault operator init -key-shares=1 -key-threshold=1 > init.txt
UNSEAL_KEY=$(grep 'Unseal Key 1:' init.txt | awk '{print $4}')
ROOT_TOKEN=$(grep 'Initial Root Token:' init.txt | awk '{print $4}')

vault operator unseal $UNSEAL_KEY
export VAULT_TOKEN=$ROOT_TOKEN

vault secrets enable -path=kv kv-v2
vault auth enable approle

vault policy write app-policy ./policies/app-policy.hcl
vault policy write admin-policy ./policies/admin-policy.hcl

vault write auth/approle/role/app-role \
    token_policies="app-policy" \
    secret_id_ttl=60m \
    token_ttl=30m \
    token_max_ttl=60m

📜 4. Example Policies
app-policy.hcl
Code
path "kv/data/app/*" {
  capabilities = ["read", "list"]
}
admin-policy.hcl
Code
path "*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}


🧩 5. Troubleshooting Scenarios (7 total)
Each scenario is a mini support ticket with:

Summary

Symptoms

Logs

Root cause

Fix

Commands used

```


Scenario 01 — AppRole Authentication Failure
Problem: App cannot authenticate using AppRole.
Root Cause: Wrong role_id or secret_id.
What you learn: How AppRole works, how to debug auth failures.

Scenario 02 — Permission Denied (Policy Issue)
Problem: Token cannot read a secret.
Root Cause: Wrong policy or wrong path.
What you learn: How to debug policy mismatches.

Scenario 03 — Token Expired
Problem: App suddenly loses access.
Root Cause: TTL too short.
What you learn: Token lifecycle, TTL, max TTL, renewal.

Scenario 04 — KV v2 Path Confusion
Problem: “No value found at path.”
Root Cause: Missing /data/ in KV v2.
What you learn: KV v1 vs KV v2 differences.

Scenario 05 — Transit Decrypt Failure
Problem: Decryption fails even though encryption succeeded.
Root Cause: Wrong key version or corrupted ciphertext.
What you learn: How Transit handles key rotation.

Scenario 06 — Vault Sealed Behavior
Problem: Vault suddenly sealed.
Root Cause: Simulated restart or storage issue.
What you learn: Seal/unseal workflow, operator commands.

**Scenario 07** — Wrong Mount Path
Problem: “No handler for route.”
Root Cause: Using default path instead of custom mount.
What you learn: How mounts work and how to debug them.
```

