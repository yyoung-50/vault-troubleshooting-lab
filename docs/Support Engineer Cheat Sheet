# Vault CLI – One‑Page Support Engineer Cheat Sheet
**Purpose:** Fast reference for real‑world troubleshooting.  
**Scope:** Top commands used in support cases, diagnostics, and customer workflows.

---

## 🔐 Authentication & Tokens
- **Login:** `vault login <token>`
- **Token lookup:** `vault token lookup`
- **Token renew:** `vault token renew`
- **Capabilities:** `vault token capabilities <token> <path>`

---

## 🏗️ Core System Operations
- **Status:** `vault status`
- **Init:** `vault operator init`
- **Unseal:** `vault operator unseal <key>`
- **Seal:** `vault operator seal`

---

## 📦 Secrets Engines
- **List engines:** `vault secrets list`
- **Enable KVv2:** `vault secrets enable -path=my-kv kv-v2`
- **Disable engine:** `vault secrets disable my-kv/`

---

## 🔑 KVv2 Secrets
- **Write:** `vault kv put secret/app key="value"`
- **Read:** `vault kv get secret/app`
- **List:** `vault kv list secret/`
- **Delete version:** `vault kv delete secret/app`
- **Destroy version:** `vault kv destroy -versions=3 secret/app`

---

## 🧭 AppRole
- **List roles:** `vault list auth/approle/role`
- **Read role config:** `vault read auth/approle/role/app-role`
- **Get RoleID:** `vault read auth/approle/role/app-role/role-id`
- **New SecretID:** `vault write -f auth/approle/role/app-role/secret-id`
- **Login:** `vault write auth/approle/login role_id="$ROLE_ID" secret_id="$SECRET_ID"`

---

## 🔐 Transit Encryption
- **List keys:** `vault list transit/keys`
- **Read key:** `vault read transit/keys/my-key`
- **Encrypt:** `vault write transit/encrypt/my-key plaintext=$(base64 <<< "hello")`
- **Decrypt:** `vault write transit/decrypt/my-key ciphertext="vault:v1:..."`

---

## 🛡️ Policies
- **List:** `vault policy list`
- **Read:** `vault policy read <policy-name>`
- **Write:** `vault policy write <policy-name> <file.hcl>`

---

## 🧪 Diagnostics & Debugging
- **Check env vars:** `env | grep VAULT`
- **Health endpoint:** `curl -v $VAULT_ADDR/v1/sys/health`
- **List paths:** `vault list <path>/`
- **Read metadata:** `vault read secret/metadata/<path>`

---

## 📝 Quick Notes
- KVv2 uses `/data/` and `/metadata/` paths internally.  
- AppRole requires matching **RoleID + SecretID**.  
- Transit ciphertext always starts with `vault:v1:`.  
- Policies must explicitly allow the path.  
- Token TTLs matter for long‑running apps.

---

**Designed for:**
Support engineers, DevOps, SREs, and anyone troubleshooting Vault in real environments.
