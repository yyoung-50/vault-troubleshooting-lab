<p align="center">
  <img src="https://img.shields.io/badge/Status-Work_in_Progress-yellow" width="220">
</p>

# Vault Troubleshooting Lab (Beta Version)

This lab is designed to simulate real-world Vault technical issues. I encountered some of these issues learning Vault and thought I would share my knowledge and also learn more about troubleshooting Vault.

There are **troubleshooting scenarios** that represent examples of some common issues working with Vault. The goal of this lab is to help you build a repeatable troubleshooting workflow to strengthen the ability to diagnose and resolve Vault issues.

---

## Overview

This lab provides an environment to practice:

- Reproducing common Vault Errors  
- Reading and interpreting error messages  
- Diagnosing misconfigurations  
- Understanding Vault behavior (auth, policies, KV, transit, sealing)  
- Documenting findings clearly and professionally  

Each troubleshooting scenario is written like a **mini support ticket** or support case and includes:

- Summary  
- Symptoms  
- Reproduction steps  
- Diagnostic workflow  
- Root cause  
- Fix  
- Takeaways  

---

## Prerequisites (Required Before You Begin)

This lab runs **Vault inside a Docker container**.  
You **must** install Docker before running any Vault CLI commands.

### Required tools:
- **Docker Desktop** (mandatory)  
- **Docker Compose** (included with Docker Desktop)
- **Vault CLI** installed locally
- **jq** installed (for parsing JSON)
- A terminal environment (Git Bash, WSL, macOS Terminal, etc.)
- VS Code or any code editor

Note: - **Vault CLI installed locally** (the CLI runs on your machine; the Vault server runs inside a Docker container)

If you need help installing these tools, see the full setup guide:  
📄 **docs/environment-setup.md**

---

## ⚠️ Before You Begin

Vault in this lab **does not** run directly on your machine.  
It runs **inside a Docker container**, and all Vault data is stored in a bind-mounted folder.

Before running any Vault commands, you must:

- Install **Docker Desktop**
- Ensure Docker is running
- Clone this repository (this automatically creates the required folder structure)

---

## Lab Setup Overview

These are quick-start commands after installing Docker Desktop.

### 1. Install Docker Desktop
Make sure Docker is running before continuing.
```
Download from: https://www.docker.com/products/docker-desktop
```

### 2. Clone this project
Cloning the repo automatically creates the **correct** folder structure.

```bash
git clone <your-repo>
cd vault-troubleshooting-lab
```

### 3. Start the Vault container
This pulls the official Vault image and runs Vault inside Docker.

```bash
docker-compose up -d
```

### 4. Initialize and unseal Vault
This script configures Vault for the troubleshooting cases.

```bash
chmod +x setup/init-vault.sh
./setup/init-vault.sh
```
### 5. Point your CLI to the running Vault
```bash
export VAULT_ADDR="http://127.0.0.1:8200"
vault status
```

If Vault is sealed or uninitialized, see the full lab reset guide:
[Resetting the Lab](docs/Resetting-the-Lab.md)

### Lab Folder Structure

The **scenarios** folder contains seven troubleshooting examples to practice.

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
Full folder structure explanation
docs/folder-structure.md

---
## About the Scenarios

**What is a Scenario?**  
A scenario in this lab is a **Vault troubleshooting case**; a small, self‑contained “mini ticket” where something in Vault isn’t working as expected. You’ll encounter a realistic error message, identify the root cause, and walk through the steps to fix it. 

Each scenario includes:

- an **error message**

- a **misconfiguration or mistake**

- a **realistic** problem you might encounter in a support or engineering role

All scenarios are standalone exercises and are located in the scenarios/ folder.

## Included Scenarios

- AppRole Authentication Failure

- Permission Denied (Policy Issue)

- Token Expired (TTL Issue)

- KV v2 Path Confusion

- Transit Decrypt Failure

- Vault Seal Behavior

- Wrong Mount Path

Start with Scenario 01:
[Approle Auth Failure](scenarios/01-approle-auth-failure.md)
---

**How to Work with the Scenarios** 

To ensure consistent results, before starting a new scenario, run the "./reset-lab.sh" command 

Each scenario follows the same workflow:

- Read the scenario

- Reproduce the issue

- Diagnose the problem

- Identify the root cause

- Apply the fix

- Document your takeaways

Full detailed guide:
[How to Use This Lab](docs/How-to-Use-This-Lab.md)
---

## Resetting the Lab (Full Reset)

To completely reset Vault to a clean state, run:

```bash
./reset-lab.sh
```
Full detailed reset guide:

see [Resetting the Lab](docs/Resetting-the-Lab.md)

## Additional Documentation

- Environment Setup → docs/environment-setup.md

- Full Project Blueprint → docs/full-project-blueprint.md

- How to Use This Lab → docs/vault-concepts.md

- Cheat Sheets → docs/cheat-sheets/
---
## **Author**

**Yvonne Young**  
*Cloud & Support Engineer*  
Focused on customer advocacy, troubleshooting, and clean documentation.

---

## 📫 Let's Connect

🔗 **LinkedIn:**  
https://www.linkedin.com/in/yvonne-young




