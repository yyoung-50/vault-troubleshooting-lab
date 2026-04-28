
---

## Ticket # 456703  - Token Expired (TTL Issue)

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
# TTL for token is 0s
```
1. Ensure Vault is running and initialized:

- This step assumes you ran the **reset-lab.sh** script.  See steps to run script: [Lab Setup Script](../README.md#4-run-the-lab-setup-script)
- After running the reset script, save the output to use the **Root token** in later exercises.

**Reproduce the Issue**

2. Create a short-lived token:
```bash
vault token create -policy="app-policy" -ttl=50s
```
3. Use the token from the command output and run the commands:

```bash
export VAULT_TOKEN="short-lived-token"
vault kv get kv/app/config
```
Command will succeed, and secrets are retrieved 

4. Wait 45-60 seconds, then try again:

```bash 
vault kv get kv/app/config
```
Command failed at the TTL expiration of 50s after running the command a second time.

![Vault Login Output](https://raw.githubusercontent.com/yyoung-50/vault-troubleshooting-lab/main/screenshots/scenario01/kv-get-error.png)

**Diagnose the Problem**

5. Create another **short-lived token** that expires in 50 seconds, and run "vault token lookup" to check TTL. 

To run the next commands, you need to first export the **root token** with full permissions. (Use root token from lab reset script)

```bash
export VAULT_TOKEN="root_token"
```
Create a short-lived token:

Run:
```bash
vault token create -policy="app-policy" -ttl=50s
```
- Use **short-lived token** output for next command:
- Check the token details:

Run:
```bash
vault token lookup "short-lived-token"
```

The output shows the TTL is too short:
Note the TTL (Time To Live)

<img src="https://github.com/yyoung-50/vault-troubleshooting-lab/blob/main/screenshots/scenario01/ttl-16-seconds.png" width="500">

**Identify the Root Cause**

- Token TTL was too short for the application’s usage pattern.

- Token was not renewed before expiration.

**Apply the Fix**

The fix is to create a longer-lived token

1. Create a longer-lived token (for testing):

```bash
vault token create -policy="app-policy" -ttl=1h
```

The result of this command, would create a token that would last longer for 1 hour.

<img src="https://github.com/yyoung-50/vault-troubleshooting-lab/blob/main/screenshots/scenario01/tokenexpired.png" width="500">

2. For production:

- Use renewable tokens.

- Implement token renewal in the application.


**Key findings**

- Token TTL and renewal are critical for stable access.

- Support engineers should:

- Always verify:

   - Check token TTL and renewable flag.
   - Educate users on renewal patterns.

  ---

After you complete a scenario run the setup script: [Lab Setup Script](../README.md#4-run-the-lab-setup-script)

You are now ready to go to the next scenario file: 



