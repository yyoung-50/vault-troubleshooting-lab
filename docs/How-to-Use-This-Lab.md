## How to Use This Lab

Each troubleshooting scenario represents some common issues that support engineers encounter when working with Vault.  
The goal is to help you build a repeatable troubleshooting workflow and strengthen your ability to diagnose and resolve Vault or any technical issue when working with applications and systems.

---

## Lab Folder Structure

**The key files and folders are:**


| Path / File | Description |
|-------------|-------------|
| `vault-troubleshooting-lab/` | Lab project root folder |
| `setup/` | Contains initialization script, roles, and policies |
| `scenarios/` | Contains troubleshooting scenario files |
| `docker-compose.yml` | Defines how the Vault server runs inside Docker |
| `config.hcl` | Vault configuration file |
| `reset-lab.sh` | Script used to reset the Vault environment |
| `README.md` | Main documentation file for the Vault Troubleshooting Lab |

**Folder structure in VS Code**
```
vault-troubleshooting-lab/
│
├── README.md
├── docker-compose.yml
├── setup/
│   ├── init-vault.sh
│   ├── policies/
│   └── roles/
├── scenarios/
│   ├── 01-approle-auth-failure.md
│   ├── 02-policy-deny.md
│   ├── 03-token-expired.md
│   ├── 04-kvv2-path-issue.md
│   ├── 05-transit-decrypt-failure.md
│   ├── 06-seal-behavior.md
│   └── 07-wrong-mount-path.md
└── docs/
    ├── environment-setup.md
    ├── resetting-the-lab.md
    ├── how-to-use-this-lab.md
    ├── folder-structure.md
    └── cheat-sheets/
```

**Each scenario file in the scenarios folder contains:**

- A short summary of the issue
- Symptoms you will observe
- Commands to reproduce the failure
- Diagnostic steps
- The root cause
- The fix
- Key takeaways

### How to Work Through a Scenario

**Troubleshooting Scenarios**

```
1. AppRole Authentication Failure

2. Permission Denied (Policy Issue)

3. Token Expired (TTL Issue)

4. KV v2 Path Confusion

5. Transit Decrypt Failure

6. Vault Seal Behavior

7. Wrong Mount Path
```

- Each scenario is a separate exercise and written like a mini ticket. You work on each scenario independently and reset the lab after each one.  Each scenario follows the same workflow:

**1. Read the Scenario**

- Open the file called 01-approle-auth-failure.md

- Review the summary, symptoms, and error output.


**2. Reproduce the Issue**

- Use the commands provided in the scenario to intentionally trigger the failure.
- Take a screenshot of the error output and add your own notes.

This helps you understand how the issue presents itself in a real environment.

**3. Diagnose the Problem**

Follow the diagnostic steps in the scenario:

- Inspect Vault paths

- Read policies

- Check auth methods

- Validate tokens

- Compare expected vs. actual behavior

Add screenshots and commentary as you go.

**4. Identify the Root Cause**

- Each scenario includes a high-level explanation of what’s actually wrong.

- Use this section to confirm your findings and add your own reasoning.

**5. Apply the Fix**
- Run the commands provided in the “Fix” section.

- Take a screenshot of the successful output and describe what changed.

**6. Capture Your Takeaways**

Each scenario ends with a short list of what the issue teaches.

- Add your own reflections:

- What you learned

- How you would explain this to a customer

**Recommended Workflow for Screenshots & Notes**

For each scenario:

- Screenshot the error

- Screenshot the diagnostic commands

- Screenshot the fix

- Add your own commentary under each section

- Commit your updated .md file to your repo
