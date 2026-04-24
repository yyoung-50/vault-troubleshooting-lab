## How to Use This Lab

This document has detailed instructions on walking through a troubleshooting scenario.

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
├── config.hcl
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

**Each troubleshooting scenario file in the scenarios folder contains:**

- A short summary of the issue
- Symptoms you will observe
- Commands to reproduce the failure
- Diagnostic steps
- The root cause
- The fix and key findings

## How to Work Through a Scenario

**Vault Error Topics**

There are seven Vault troubleshooting topics
```
1. AppRole Authentication Failure
2. Permission Denied (Policy Issue)
3. Token Expired (TTL Issue)
4. KV v2 Path Confusion
5. Transit Decrypt Failure
6. Vault Seal Behavior
7. Wrong Mount Path
```

- Each scenario file is a separate exercise and written like a mini support ticket. You work on each file independently and reset the lab after each one and go to the next file.  

- All of the commands you need to diagnose and fix the Vault issue are in the file.

**1. Read the Scenario**

- Go to the **scenarios folder** in the **Explorer sidebar** 

- Open a file called **01-approle-auth-failure.md**

- Review the summary, symptoms, and error output.

**2. Reproduce the Issue**

- Use the commands provided in the scenario file to intentionally trigger the failure.

- Take a screenshot of the error output and add your own notes.

**3. Diagnose the Issue**

Follow the diagnostic steps in the scenario:

- Inspect Vault paths
- Read policies
- Check auth methods
- Validate tokens
- Compare expected vs. actual behavior

**4. Identify the Root Cause**

- An explanation of what’s actually wrong.

- Screenshots of the error messages.

**5. Apply the Fix**
- Run the commands provided in the “Fix” section.

**6. Key Findings**

- Summary of the issue including screenshots



