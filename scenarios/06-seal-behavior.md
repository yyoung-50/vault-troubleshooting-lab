
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

## Error Output
`Vault is sealed`.
```
**Reproduce the issue**

1. Restart the container:

```bash
docker-compose restart
```

2. Try a command:

```bash
export VAULT_ADDR="http://127.0.0.1:8200"
vault status
```

**Diagnose the Problem**

Check status of Vault:

```bash
vault status
```

Look for output:

- Sealed: true

- Key Shares

**Identify the Root Cause**

- Vault was restarted and is sealed by design.

- Unseal key was not applied.

**Apply the Fix**

1. Get the unseal key from the **init.txt** file:

```bash
UNSEAL_KEY=$(grep 'Unseal Key 1:' init.txt | awk '{print $4}')
vault operator unseal "$UNSEAL_KEY"
```
2. Verify Vault status
```bash
vault status
```

**Document Your Takeaways**

- Sealing is a security feature, not a bug.

- Support engineers should:

  - Recognize sealed state quickly.

  - Guide users through unseal process.