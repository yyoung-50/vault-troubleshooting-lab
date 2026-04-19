
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

```
**Reproduce the issue**

1. Ensure KV v2 is enabled at `kv/` (done in setup).

2. Write a secret:

```bash
vault kv put kv/app/config api_key="super-secret-api-key"
```
3. Try to read using the wrong path (API style):

```bash 
vault read kv/app/config
```
**Diagnose the Problem**

Understand KV v2 paths:

- CLI vault kv get kv/app/config → handles /data/ internally.

- API path is kv/data/app/config.

Check:

```bash 
vault kv get kv/app/config
vault read kv/data/app/config
```

**Identify the Root Cause**

- Confusion between KV v1 and KV v2 paths.

- Using kv/app/config instead of kv/data/app/config with the raw API.

**Apply the Fix**

- Use vault kv get kv/app/config with the CLI.

- Use kv/data/app/config for API calls.

**Document Your Takeaways**

- KV v2 introduces a /data/ and /metadata/ path structure.

- Many real-world tickets are caused by this exact confusion.

