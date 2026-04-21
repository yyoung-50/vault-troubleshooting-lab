<p align="center">
  <img src="https://img.shields.io/badge/Status-Work_in_Progress-yellow" width="220">
</p>

# Vault Troubleshooting Lab (Beta Version)

This lab simulates common errors you’ll encounter when learning and working with HashiCorp Vault. It’s based on real issues I ran into while troubleshooting Vault. The goal of this lab is to show examples of a troubleshooting workflow to isolate an error as an example of the thought process of solving a technical problem.

Each scenario walks through a practical troubleshooting workflow similar to what support engineers use to validate a system, isolate an issue, and fix the root cause. While the examples are Vault-specific, the approach can be applied to troubleshooting technical issues in general.

---

### Overview

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

### Prerequisites (Required Before You Begin)

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

If you need help installing these tools, see the full setup guide below:  
[Vault Setup Guide](docs/environment-setup.md)

---

### ⚠️ Before You Begin

Vault in this lab **does not** run directly on your machine.  
It runs **inside a Docker container**, and all Vault data is stored in a bind-mounted folder.

Before running any Vault commands, you must:

- Install **Docker Desktop**
- Ensure Docker is running
- Clone this repository (this automatically creates the required folder structure)

---

### Lab Setup Overview

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

### 5. Point your CLI to the running Vault server

```bash
export VAULT_ADDR="http://127.0.0.1:8200"
vault status
```
Running the **vault status** command verifies that your CLI can reach the Vault server and that Vault is initialized and unsealed

You are now ready to work through the troubleshooting scenarios in the next steps below.

### About the Scenarios

**What is a Scenario?**  

A scenario in this lab is a **Vault troubleshooting case**; a small, self‑contained “mini ticket” where something in Vault isn’t working as expected. You’ll encounter a realistic error message, identify the root cause, and walk through the steps to fix it. 

Each scenario includes:

- an **error message**

- a **misconfiguration or mistake**

- a **realistic** problem you might encounter in a support or engineering role

All scenarios are standalone exercises and are located in the scenarios/ folder.

### Included Scenarios

The troubleshooting **scenarios** folder contains seven files to practice working with Vault errors.

They are located in the **scenarios folder**  in the **Explorer sidebar** (left side of VS Code)

- AppRole Authentication Failure

- Permission Denied (Policy Issue)

- Token Expired (TTL Issue)

- KV v2 Path Confusion

- Transit Decrypt Failure

- Vault Seal Behavior

- Wrong Mount Path

**Start with Scenario 01:** 👉 Click here: [AppRole Auth Failure](scenarios/01-approle-auth-failure.md)

---

**How to Work with the Scenarios** 

To ensure consistent results, before starting a new scenario, run the "./reset-lab.sh" command.

After your complete one scenario, run the "./reset-lab.sh" command and go to the next scenario file.

- For for example, go to the **Explorer sidebar** (left side of VS Code), open the **scenarios folder** to select from the list of scenario files. There are 7 files

Each scenario file follows the same workflow:

- Read the scenario

- Reproduce the issue

- Diagnose the problem

- Identify the root cause

- Apply the fix

- Document your takeaways

**Full detailed guide:**  [How to Work Through a Scenario](docs/How-to-Use-this-Lab.md)

---

## Resetting the Lab (Full Reset)

To completely reset Vault to a clean state, run:

```bash
./reset-lab.sh
```
**Full detailed reset guide:**   see 👉 [Resetting the Lab](docs/Resetting-the-Lab.md)

### Additional Documentation

- Environment Setup → [Vault Lab Setup](docs/environment-setup.md)

- How to Use This Lab → [How to Use this Lab](docs/How-to-Use-this-Lab.md)

- Resetting the Lab → [Resetting the Lab](docs/Resetting-the-Lab.md)

- Verify Script → [Verify Script](docs/Verify-script.md)

- Support Engineer Vault Cheat Sheet [Support Engineer Vault Cheatsheet](docs//Support-Engineer-Cheat-Sheet.md)

- Top 20 Vault Commands → [Top 20 Vault Commands](docs/Top-20-Vault-Commands.md)

---

### Author

**Yvonne Young**  
*Cloud & Support Engineer*  
Focused on customer advocacy, troubleshooting, and clean documentation.

---

### 📫 Let's Connect

🔗 **LinkedIn:**  
https://www.linkedin.com/in/yvonne-young




