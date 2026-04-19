# Scenario XX – <Short Scenario Title>

## Summary
A brief description of the issue from the customer’s perspective.  
One or two sentences explaining what is failing and how it was discovered.

---

## Symptoms
List the observable behaviors that indicate something is wrong.

Examples:
- CLI errors
- Application logs
- Unexpected Vault responses
- Missing data or denied access

Add a screenshot here:
![screenshot-placeholder](#)

---

## Reproduction Steps
Steps to intentionally reproduce the issue in your lab.

### 1. Ensure Vault is running
```bash
export VAULT_ADDR="http://127.0.0.1:8200"
vault status

2. Set up scenario-specific variables

# Example
export ROLE_ID=$(cat setup/roles/app-role-id.txt)
export SECRET_ID=$(cat setup/roles/app-secret-id.txt)

3. Trigger the failure

# Example
vault write auth/approle/login role_id="wrong" secret_id="$SECRET_ID"

Add a screenshot here:
[Looks like the result wasn't safe to show. Let's switch things up and try something else!]

Your commentary:

What you expected to happen

What actually happened
```
Diagnosis
Explain how you investigated the issue.

Key checks
What configuration did you inspect?

What commands did you run?

What values did you compare?

Useful commands

vault read <path>
vault list <path>
vault write <path>
vault login <method>

Add a screenshot here:
[Looks like the result wasn't safe to show. Let's switch things up and try something else!]

Your commentary:

What stood out

What didn’t match expectations

What clues led you to the root cause
```

Root Cause
A concise, factual explanation of what was actually wrong.

Examples:

“The RoleID and SecretID belonged to different AppRoles.”

“The policy denied access to the path the application needed.”

“The token had expired due to a short TTL.”

Your commentary:

Why this root cause makes sense

How you confirmed it
```

Fix
Show the exact commands or configuration changes that resolve the issue.

# Example
vault write -f auth/approle/role/app-role/secret-id
vault write auth/approle/login role_id="$ROLE_ID" secret_id="$SECRET_ID"

Add a screenshot here:
[Looks like the result wasn't safe to show. Let's switch things up and try something else!]

Your commentary:

What changed

Why this resolves the issue
```

Takeaways
Short bullet points summarizing what this scenario teaches.

Examples:

AppRole authentication requires both RoleID and SecretID to match.

Policies must explicitly allow the path being accessed.

Token TTLs and renewals matter for long‑running applications.

KVv2 paths differ from KVv1 and must be referenced correctly.

Your commentary:

What you personally learned

How this scenario improves your troubleshooting skills
```