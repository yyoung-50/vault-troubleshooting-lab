
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

## Error Output:

```bash
vault kv get kv/app/config
# Error reading kv/app/config: permission denied

```

**Reproduce the issue**

1. Create a token with a restricted policy (simulate a misconfigured policy):

```bash
vault token create -policy="default" -ttl=30m
```
2. Use that token:

```bash
export VAULT_TOKEN="<new-token>"
vault kv get kv/app/config
```

**Diagnose the Problem**

1. Which policies are attached to the token?

```bash
vault token lookup
```

2. What does the app-policy allow?

```bash
vault policy read app-policy
```

3. Is the token actually using app-policy?

**Identify the Root Cause**

- The token does not have the app-policy attached.

- Or the policy path is wrong (e.g., kv/app/* instead of kv/data/app/* for KV v2).

**Apply the Fix**

1. Retrieve the correct Role ID:

```bash
vault token create -policy="app-policy" -ttl=30m
```

2. Generate a new Secret ID:

```bash
export VAULT_TOKEN="<new-app-policy-token>"
vault kv get kv/app/config
```

**Document Your Takeaways**

- Policy issues are one of the most common Vault problems.

- Always verify:

  - Which policies are attached to the token

  - Whether the policy paths match the engine type (KV v1 vs KV v2)
