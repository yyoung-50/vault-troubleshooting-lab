
---

## `scenarios/03-token-expired.md`

```markdown
# Scenario 03 – Token Expired (TTL Issue)

## Summary

An application suddenly loses access to Vault. It worked earlier, but now all requests fail.

---

## Symptoms

- Requests that previously worked now fail.

## Error Output
- Errors mention “expired token” or “permission denied.”
- `vault token lookup` shows `expired_time` in the past.

```bash
vault token lookup
```
**Reproduce the Issue**

1. Create a short-lived token:
```bash
vault token create -policy="app-policy" -ttl=30s
```
2. Use the token from the command output:

```bash
export VAULT_TOKEN="hvs.CAESIFiw4rTsAOCE4ghY
vault kv get kv/app/config
```
Command will succeed

3. Wait 45-60 seconds, then try again:

```bash 
vault kv get kv/app/config
```
Command will fail

**Diagnose the Problem**

Check the token details:

```bash
vault token lookup "<short-lived-token>"
```

Look at the output:

- ttl

- expire_time

- renewable

**Identify the Root Cause**

- Token TTL was too short for the application’s usage pattern.

- Token was not renewed before expiration.

**Apply the Fix**

1. Create a longer-lived token (for testing):

```bash
vault token create -policy="app-policy" -ttl=1h
```

![Vault Login Output](https://raw.githubusercontent.com/yyoung-50/vault-troubleshooting-lab/main/screenshots/scenario01/tokenexpired.png)


2. For production:

- Use renewable tokens.

- Implement token renewal in the application.


**Document Your Takeaways**

- Token TTL and renewal are critical for stable access.

- Support engineers should:

- Always verify:

   - Check token TTL and renewable flag.
   - Educate users on renewal patterns.

   



