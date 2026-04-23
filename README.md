<p align="center">
  <img src="https://img.shields.io/badge/Status-Work_in_Progress-yellow" width="220">
</p>


# Vault Troubleshooting Lab 

This project is a hands-on HashiCorp Vault troubleshooting lab built around some of the issues I ran into while learning Vault. There are troubleshooting scenarios that present specific errors, along with the commands used, what went wrong, and the step-by-step process to fix them. Each scenario is written like a mini support ticket, similar to what you’d see during a real support call.

The goal of this project is to show how to break down and isolate issues. I outline the step-by-step process behind troubleshooting that you can apply to Vault or any technical issue.

![Vault Login Output](https://raw.githubusercontent.com/yyoung-50/vault-troubleshooting-lab/main/screenshots/scenario01/trouble-ticket-small.png)

**Ticket # 456790 - AppRole Authentication Failure**

---

### Prerequisites 
No prior Vault setup required. The lab environment is fully automated after setup.

- **Docker Desktop** (mandatory)  
- **Docker Compose** (included with Docker Desktop)
- **Vault CLI** (optional installed locally)
- **jq** installed (for parsing JSON)
- A terminal environment (Git Bash, WSL, macOS Terminal, etc.)
- **VS Code** or any code editor (This lab assumes you are running VS Code)

If you need help installing these tools, see the full setup guide below:  

[Vault Setup Guide](./docs/environment-setup.md)

---

### Lab Setup 

### 1. Install Visual Studio Code (Recommended)
```
Download VS Code:  see https://code.visualstudio.com/
```

### 2. Install Docker Desktop

Download from: https://www.docker.com/products/docker-desktop
```
After installation, make sure the Vault container is running before continuing.
```

### 3. Clone this project
This project is designed as a hands-on Vault troubleshooting lab.

To get the most value, clone the repository and follow the exercises locally:

```bash
git clone https://github.com/yyoung-50/vault-troubleshooting-lab.git
cd vault-troubleshooting-lab
```
### 4. Run the Lab Setup Script

Run the lab setup script ** reset-lab.sh" located vault-troubleshooting-lab project folder

```bash
source reset-lab.sh
```
### 5. Confirm Vault is Initialized and Unsealed

```bash
vault status
```
Vault status output will show:
Initialized: true
Sealed: false

---

You are now ready to work through the troubleshooting scenarios in the next steps below.

### Troubleshooting Scenarios

**Working with Scenario files** 

- The Vault troubleshooting scenario files are written as small, self‑contained “mini tickets” where Vault is misconfigured. 

- Assuming you are working in VS Code, the files are located in the **scenarios folder** in the **Explorer sidebar** 

Each scenario file has all of the commands to diagnose and fix the Vault issues:

- Read the scenario
- Run through the commands to reproduce the issue
- Run through the commands to diagnose the problem
- Run through the commands to apply the fix
- Key findings and solutions

**Start with Scenario 01:** 👉 Click here: [AppRole Auth Failure](scenarios/01-approle-auth-failure.md)

If you need more help walking through the scenario files, here's a walk through guide:
[How to Work Through a Scenario](docs/How-to-Use-this-Lab.md)

After you complete one scenario, run the reset script and check Vault status.

```bash
source reset-lab.sh
vault status
```
- Vault status output will show:
- Initialized: **true**
- Sealed: **false**

**Vault is initialized and unsealed.**

Make a note of the role ID, secret ID, and root token for the troubleshooting scenario exercises.

You are now ready to go to the next scenario file:

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




