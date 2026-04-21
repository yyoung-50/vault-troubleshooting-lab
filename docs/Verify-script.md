## Verifying the Vault Initialization Script

After running the **init-vault.sh** script, run the following commands to confirm that Vault is initialized, unsealed, and correctly configured.

---

| Check | Command | Expected Result |
|-------|---------|-----------------|
| Vault initialized | `vault status` | Initialized: true |
| Vault unsealed | `vault status` | Sealed: false |
| KV v2 enabled | `vault secrets list` | kv/ (kv-v2) |
| AppRole enabled | `vault auth list` | approle/ |
| Policies loaded | `vault policy list` | app-policy present |
| AppRole created | `vault list auth/approle/role` | app-role present |
| Role ID exists | `vault read auth/approle/role/app-role/role-id` | returns ID |
| Secret ID endpoint works | `vault write -f auth/approle/role/app-role/secret-id` | returns secret_id |

---

A detailed checklist of the commands to verify that the **init-vault.sh** script was successful.

**1. Check Vault Status**
```bash
vault status
```
Expected output:
- Initialized: true
- Sealed: false
- Storage Type: file

**2. Verify KV v2 is Enabled**
```bash
vault secrets list
```
Expected output:
```bash
kv/   kv   kv-v2
```

**3. Verify AppRole Auth Method Is Enabled**
```bash
vault auth list
```

Expected output:
```bash
approle/    auth_approle
```

**4. Confirm Policies Were Loaded**
```bash
vault policy list
```
Expected output:
- default
- root
- app-policy

View the policy:

```bash
vault policy read app-policy
```

**5. Verify AppRole Role Exists**
```bash
vault list auth/approle/role
```

Expected output:
```bash
app-role
```
View the role:
```bash
vault read auth/approle/role/app-role
```

**6. Confirm Role ID and Secret ID Were Generated**
```bash
vault read auth/approle/role/app-role/role-id
vault write -f auth/approle/role/app-role/secret-id
```
These should return valid IDs.

After verifying the Vault initialization script ran successfully, run the following two commands:

**6. Tell the Vault CLI which Vault server to talk to**

```bash
export VAULT_ADDR="http://127.0.0.1:8200"
vault status
```
Running the **vault status** command verifies that your CLI can reach the Vault server and that Vault is initialized and unsealed

You are now ready to work through a troubleshooting scenario.

Start here: [How to Work Through a Scenario](/docs/How-to-Work-Through-a-Scenario.md)