
---

## Ticket # 456704  - Secrets Engine Path Confusion

```markdown
# Scenario 04 – Key-Value (KV) Secrets Engine Path Confusion

## Summary

A user cannot read a secret from KV v2. They get “No such file or directory" even though the secret exists.

---

## Symptoms

- `vault kv read kv/app/config` fails.
- User insists “I wrote the secret already.”

## Error Output
- Error: `no value found at kv/app/config`.

```bash
vault kv read kv/app/config
```
**Reproduce the issue**

1. Confirm the version of KV at `kv/` (should be enabled)


```bash
vault secrets list --detailed

```

2. Write a secret:

```bash
vault kv put kv/app/config api_key="super-secret-api-key-03"
```
3. Try to read using the wrong path (API style):

```bash 
vault read kv/app/config
```

Error output: Invalid path for a versioned K/V secrets engine.

**Diagnose the Problem**

The issue is for KV v2, either use "vault kv get" or include data in the path.  KV v2 requires /data/ in the API calls:

- CLI vault kv get kv/app/config → handles /data/ internally.

- API path is kv/data/app/config.

Check solution:

```bash 
vault kv get kv/app/config
vault read kv/data/app/config
```

**Identify the Root Cause**

- Confusion between KV v1 and KV v2 paths.

- Using kv/app/config instead of kv/data/app/config with the raw API.

**Apply the Fix**

- Use vault **kv get kv/app/config** with the CLI.

- Use **kv/data/app/config** for API calls.

**Key Takeaways**

- KV v2 introduces a /data/ and /metadata/ path structure.

- Many real-world tickets are caused by this exact confusion.

---

After you complete a scenario run the setup script: [Lab Setup Script](../README.md#4-run-the-lab-setup-script)

You are now ready to go to the next scenario file: