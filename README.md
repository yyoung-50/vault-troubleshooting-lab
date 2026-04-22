
# Vault Troubleshooting Lab 

This project is a hands-on HashiCorp Vault troubleshooting lab built around issues I ran into while learning Vault. Each troubleshooting scenario presents a specific error, along with the commands used, what went wrong, and the step-by-step process to fix it.

The goal isn’t just to resolve the issue, but to show how to break down and isolate problems. I focus on the thought process behind troubleshooting so you can apply the same approach to Vault or any technical issue.

### Prerequisites 

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

[Vault Setup Guide](./docs/How-to-Use-this-Lab.md)

---

### ⚠️ Before You Begin

Vault in this lab **does not** run directly on your machine.  
It runs **inside a Docker container**, and all Vault data is stored in a bind-mounted folder.

Before running any Vault commands, you must:

- Install **Docker Desktop**
- Ensure Docker is running
- Clone this repository (this automatically creates the required folder structure)

---

### Lab Setup 

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

### Troubleshooting-Scenarios

**Working with Scenario files** 

- The Vault troubleshooting scenario files are written as small, self‑contained “mini tickets” where Vault is misconfigured. 

- The files are located in the **scenarios folder**  in the **Explorer sidebar** 

Each scenario file has all of the commands to diagnose and fix the Vault issues:

- Read the scenario
- Run through the commands to reproduce the issue
- Run through the commands to diagnose the problem
- Run through the commands to apply the fix
- Key findings and solutions

**Start with Scenario 01:** 👉 Click here: [AppRole Auth Failure](scenarios/01-approle-auth-failure.md)

If you need more help walking through the scenario files, here's a walk through guide:
[How to Work Through a Scenario](docs/How-to-Use-this-Lab.md)

After you complete one scenario, run the reset script and go to the next scenario file.

```bash
./reset-lab.sh
```

### Resetting the Lab 

**Full detailed reset guide:**  see 👉 [Resetting the Lab](docs/Resetting-the-Lab.md)

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




