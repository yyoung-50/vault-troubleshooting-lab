
---

## Ticket # 456706  - Vault Seal Behavior

```markdown
# Scenario 06 – Vault Seal Behavior

## Summary

Vault appears “down” or “unavailable” after a restart. Users cannot access secrets.

---

## Symptoms

- CLI commands fail with `Vault is sealed`.
- UI shows Vault as sealed.
- Apps cannot authenticate.

## Error Output
`Vault is sealed`.
```
1. Ensure Vault is running and initialized:

- This step assumes you ran the **reset-lab.sh** script.  See steps to run script: [Lab Setup Script](../README.md#4-run-the-lab-setup-script)
- After running the reset script, save the output to use the **Root token** in later exercises.

**Reproduce the issue**

1. Restart the container:

Run:
```bash
docker-compose restart
```

2. Try a command:

```bash
vault secrets list
```
Error output saying **Vault is sealed**

<img src="https://github.com/yyoung-50/vault-troubleshooting-lab/blob/main/screenshots/scenario01/vault-sealed.png" width="500">

**Diagnose the Problem**

Check status of Vault:

```bash
vault status
```
Look for output:

Output shows vault is sealed "Sealed:true"

<img src="https://github.com/yyoung-50/vault-troubleshooting-lab/blob/main/screenshots/scenario01/vault-sealed-output.png" width="500">

**Identify the Root Cause**

- Vault was restarted and is sealed by design.

- Unseal key was not applied.

**Apply the Fix**

1. Run the commands to extract the unseal key from "init.txt" and to unseal Vault (init.txt already created)

Run:
```bash
UNSEAL_KEY=$(grep 'Unseal Key 1:' init.txt | awk '{print $4}')
vault operator unseal "$UNSEAL_KEY"
```

2. Verify Vault status

```bash
vault status
```
Output now shows that Vault is unsealed.

<img src="https://github.com/yyoung-50/vault-troubleshooting-lab/blob/main/screenshots/scenario01/vault-unsealed.png" width="500">

**Key Findings**

- Sealing is a security feature, not a bug.

  - Recognize sealed state quickly.

  - Guide users through unseal process.