
---

## Ticket # 456707 - Wrong Mount Path

```markdown
# Scenario 07 – Wrong Mount Path

## Summary

A user gets “no handler for route” or similar errors when trying to access a secrets engine.

---

## Symptoms

- `no handler for route` errors.
- User is calling `secret/...` when engine is mounted at `kv/`.
- Confusion about mount paths.

## Error Output running command
```bash
vault secrets list
``` 
1. Ensure Vault is running and initialized:

- This step assumes you ran the **reset-lab.sh** script.  See steps to run script: [Lab Setup Script](../README.md#4-run-the-lab-setup-script)
- After running the reset script, save the output to use the **Root token** in later exercises.

**Reproduce the issue**

1. Confirm KV is mounted at `kv/`:

```bash
vault secrets list
```
Output confirms KV is mounted at `kv/`:

<img src="https://github.com/yyoung-50/vault-troubleshooting-lab/blob/main/screenshots/scenario01/mounted-at-kv.png" width="500">

2. Try to read using the wrong path:

```bash
vault kv get secret/app/config
```
- Error running this command because it is the wrong mount path. 
- It was confirmed KV is mounted at "kv/" not "secrets/" 
- Correct command is **vault kv get kv/app/config**

<img src="https://github.com/yyoung-50/vault-troubleshooting-lab/blob/main/screenshots/scenario01/get-secret-error.png" width="500">

**Diagnose the Problem**

Verify the following:

- Where is the engine actually mounted?

- Are they using the correct mount path?

**Identify the Root Cause**

User assumes default path (secret/) but engine is mounted at kv/.  Therefore, the command, **vault kv get secret/app/config** is using an incorrect mount path **`secret/`**.

**Apply the Fix**

1. Use the correct mount path:

```bash
vault kv get kv/app/config
```
Command is retrieves secrets successfully because the engine is mounted at kv/.  

**Key Findings**

- Mount paths are configurable.

  - Ask for vault secrets list output.

  - Confirm the exact path being used.

Note: There is a general confusion between "secret/" and "kv/" mount paths

- A mount path is the location where a secrets engine lives
- secret/ and kv/ are just different mount names and are in two different locations
- They behave the same, but store different data

---

After you complete a scenario run the setup script: [Lab Setup Script](../README.md#4-run-the-lab-setup-script)

You are now ready to go to the next scenario file:

