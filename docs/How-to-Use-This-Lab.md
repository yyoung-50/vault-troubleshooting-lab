## How to Use This Lab

This lab is designed to simulate real-world Vault support cases.  
Each scenario represents a common issue that engineers encounter when working with Vault in production environments.  
The goal is to help you build a repeatable troubleshooting workflow and strengthen your ability to diagnose and resolve Vault issues quickly and confidently.

---

## Prerequisites

Before working through the scenarios, ensure you have:

- Docker and Docker Compose installed
- Vault CLI installed locally
- This repository cloned to your machine
- A working terminal environment (Git Bash, WSL, macOS Terminal, etc.)

---

## Lab Structure

The lab is organized into the following directories:

setup/         # Initialization scripts, roles, policies, and helper files
scenarios/     # Each troubleshooting scenario (01–07)
docker-compose.yml
README.md
```


Each scenario file in `scenarios/` contains:

- A short summary of the issue
- Symptoms you will observe
- Commands to reproduce the failure
- Diagnostic steps
- The root cause
- The fix
- Key takeaways

This mirrors how support engineers document internal case notes and customer-facing resolutions.

---

## Starting the Lab Environment

Each scenario assumes a clean Vault environment.  
To reset your environment:

```bash
docker rm -f vault-lab
rm -rf ./data
mkdir data
docker-compose up -d
```
Verify Vault is reachable:

```
export VAULT_ADDR="http://127.0.0.1:8200"
vault status
```
If Vault is uninitialized, run the setup script:
```
./setup/init-vault.sh
```
This script initializes Vault, unseals it, and writes the root token and unseal keys to **init.txt**.

```
How to Work Through a Scenario

## Scenarios Included in this lab

Each scenario as a separate exercise and each is written like a mini ticket. You work on each scenario independently and reset the lab after each one.

```
1. AppRole Authentication Failure
2. Permission Denied (Policy Issue)
3. Token Expired (TTL Issue)
4. KV v2 Path Confusion
5. Transit Decrypt Failure
6. Vault Seal Behavior
7. Wrong Mount Path

Each scenario follows the same workflow:
```
1. Read the Scenario

Open the corresponding file in scenarios/:

```
scenarios/01-approle-auth-failure.md
```
Review the summary, symptoms, and expected behavior.

```

2. Reproduce the Issue
- Use the commands provided in the scenario to intentionally trigger the failure.
- Take a screenshot of the error output and add your own notes.

This helps you understand how the issue presents itself in a real environment.



```

3. Diagnose the Problem
Follow the diagnostic steps in the scenario:

Inspect Vault paths

Read policies

Check auth methods

Validate tokens

Compare expected vs. actual behavior

Add screenshots and commentary as you go.

```

4. Identify the Root Cause
Each scenario includes a high-level explanation of what’s actually wrong.

Use this section to confirm your findings and add your own reasoning.
```

5. Apply the Fix
Run the commands provided in the “Fix” section.

Take a screenshot of the successful output and describe what changed.

```
6. Capture Your Takeaways
Each scenario ends with a short list of what the issue teaches.

Add your own reflections:

What surprised you

What you learned

How you would explain this to a customer


```
Recommended Workflow for Screenshots & Notes
For each scenario:

Screenshot the error

Screenshot the diagnostic commands

Screenshot the fix

Add your own commentary under each section

Commit your updated .md file to your repo

This turns your lab into a living portfolio of your troubleshooting skills.
```

Who This Lab Is For
This lab is designed for:

Support engineers preparing for Vault-related roles

Cloud/DevOps engineers who want hands-on troubleshooting practice

Anyone preparing for the Vault Associate exam

Engineers who want to demonstrate real-world debugging skills in interviews

```
What You’ll Learn
By completing all 7 scenarios, you will build confidence in:

Authentication workflows (AppRole, tokens)

Policy evaluation and access control

KVv2 path structure and versioning

Transit encryption/decryption behavior

Seal/unseal mechanics

Mount paths and namespace awareness

Diagnosing common Vault CLI and API errors

This lab gives you a structured, repeatable method for approaching Vault issues.
```

