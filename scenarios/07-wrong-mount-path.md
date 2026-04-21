
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

## Error Output
```bash
vault secrets list
``` 

**Reproduce the issue**

1. Confirm KV is mounted at `kv/`:

```bash
vault secrets list
```

2. Try to read using the wrong path:

```bash
vault kv get secret/app/config
```

**Diagnose the Problem**

Check:

- Where is the engine actually mounted?

- Are they using the correct mount path?

**Identify the Root Cause**

User assumes default path (secret/) but engine is mounted at kv/.

**Apply the Fix**

1. Use the correct mount path:

```bash
vault kv get kv/app/config
```

**Document Your Takeaways**

- Mount paths are configurable.

- Support engineers should:

  - Ask for vault secrets list output.

  - Confirm the exact path being used.
