<p align="center">
  <img src="https://img.shields.io/badge/Status-Work_in_Progress-yellow" width="220">
</p>

# Vault Troubleshooting Lab

A hands-on lab designed to simulate **real-world HashiCorp Vault support cases**.  
You will reproduce issues, diagnose failures, identify root causes, and apply fixes — just like a Vault Support Engineer.

This project is intentionally scenario-driven and focuses on building a **repeatable troubleshooting workflow**.

---

## 🚀 Overview

This lab provides a safe, controlled environment to practice:

- Reproducing common Vault failures  
- Reading and interpreting error messages  
- Diagnosing misconfigurations  
- Understanding Vault behavior (auth, policies, KV, transit, sealing)  
- Documenting findings clearly and professionally  

Each scenario is written like a **mini support ticket** and includes:

- Summary  
- Symptoms  
- Reproduction steps  
- Diagnostic workflow  
- Root cause  
- Fix  
- Takeaways  

---

## 🎯 Goals of This Lab

By completing this lab, you will demonstrate:

- Understanding of Vault core concepts  
- Ability to troubleshoot real Vault issues  
- Confidence with CLI workflows  
- Support‑engineer style communication  
- A structured, repeatable debugging method  

This lab is ideal for:

- Support engineers preparing for Vault‑related roles  
- DevOps/Cloud engineers wanting hands‑on troubleshooting practice  
- Anyone preparing for the Vault Associate exam  
- Engineers building a strong technical portfolio  

---

## 🧰 Prerequisites (Required Before You Begin)

This lab runs **Vault inside a Docker container**.  
You **must** install Docker before running any Vault CLI commands.

### Required tools:
- **Docker Desktop** (mandatory)  
- **Docker Compose** (included with Docker Desktop)
- **Vault CLI** installed locally
- **jq** installed (for parsing JSON)
- A terminal environment (Git Bash, WSL, macOS Terminal, etc.)
- VS Code or another code editor

If you need help installing these tools, see the full setup guide:  
📄 **docs/environment-setup.md**

---

## ⚠️ Before You Begin

Vault in this lab **does not** run directly on your machine.  
It runs **inside a Docker container**, and all Vault data is stored in a bind-mounted folder (`./data`).

This means:

- You must start the container **before** running any Vault CLI commands  
- You must export `VAULT_ADDR` so the CLI knows where Vault is running  
- You must initialize and unseal Vault after each reset  

Quick start:

```bash
docker-compose up -d
chmod +x setup/init-vault.sh
./setup/init-vault.sh

export VAULT_ADDR="http://127.0.0.1:8200"
vault status
```
If Vault is sealed or uninitialized, see the full lab reset guide:
/docs/resetting-the-lab.md (hyperlink here)

placeholder
**Quick Start**

This is the fastest way to get the lab running.
```bash
git clone <your-repo>
cd vault-troubleshooting-lab

docker-compose up -d
chmod +x setup/init-vault.sh
./setup/init-vault.sh

export VAULT_ADDR="http://127.0.0.1:8200"
vault status
```
Vault is not initialized, unsealed, configured and ready for scenarios.

## Lab Folder Structure

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

Scenario Index

Each scenario is a standalone troubleshooting exercise.

- AppRole Authentication Failure

- Permission Denied (Policy Issue)

- Token Expired (TTL Issue)

- KV v2 Path Confusion

- Transit Decrypt Failure

- Vault Seal Behavior

- Wrong Mount Path

Start with Scenario 01 →
📄 scenarios/01-approle-auth-failure.md
```

How to Use This Lab (Short Version)
Each scenario follows the same workflow:

Read the scenario

Reproduce the issue

Diagnose the problem

Identify the root cause

Apply the fix

Capture your takeaways

Full detailed guide →
📄 docs/how-to-use-this-lab.md
```

## Resetting the Lab (Short Version)

Before each scenario, reset Vault to a clean state:
```bash
docker-compose down
docker rm -f vault-lab 2>/dev/null

rm -rf ./data
mkdir data

docker-compose up -d

export VAULT_ADDR="http://127.0.0.1:8200"
vault status

./setup/init-vault.sh
```
Full detailed reset guide:
docs/resetting-the-lab.md

## Additional Documentation

- Environment Setup → docs/environment-setup.md

- Full Project Blueprint → docs/full-project-blueprint.md

- Vault Concepts (Beginner Friendly) → docs/vault-concepts.md

- Cheat Sheets → docs/cheat-sheets/

## Author

Yvonne Young (Connect with me: LinkedIn)

Cloud & Support Engineer

Focused on customer advocacy, troubleshooting, and clean documentation.






