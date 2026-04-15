# Vault-troubleshooting-lab

### **This project is a work in progress.  I’m building it step by step and will be completed soon.**

🔐 Vault Troubleshooting Lab
A hands‑on troubleshooting environment designed to simulate real-world HashiCorp Vault support scenarios.
This lab helps you practice diagnosing, reproducing, and resolving Vault issues — the exact skill set used by Support Engineers, SREs, and DevOps teams.

The lab runs entirely in Docker and includes:

- A Vault server

- Initialization + unseal workflow

- Preconfigured policies and roles

- Multiple break/fix scenarios

- A structured troubleshooting workflow


📁 Folder Structure
```hcl
vault-troubleshooting-lab/
│
├── docker-compose.yml
├── init-vault.sh
├── README.md
│
├── policies/
│   ├── admin-policy.hcl
│   ├── app-policy.hcl
│   └── ...
│
├── roles/
│   ├── admin-role.json
│   ├── app-role.json
│   └── ...
│
├── scenarios/
│   ├── 01-token-invalid.md
│   ├── 02-permission-denied.md
│   ├── 03-unseal-issue.md
│   ├── 04-policy-misconfigured.md
│   └── ...
│
└── docs/
    ├── troubleshooting-guide.md
    ├── architecture-overview.md
    ├── vault-concepts.md
    └── interview-talking-points.md
```

🧰 Prerequisites
This lab assumes the following tools are already installed:

- Docker & Docker Compose - see 👉 [Environment Setup](docs/environment-setup.md)

- A code editor (VS Code recommended) - see 👉 https://code.visualstudio.com/docs/setup/setup-overview

- Bash or a Unix‑like shell

- Basic familiarity with Vault CLI commands

> **Note:** This lab requires **Docker Desktop**.  
> If you need help setting up your environment,  
> see 👉 [Environment Setup](docs/environment-setup.md)

**Note:* This lab requires a time commitment. You first have to install Docker and setup your environment before you start running the lab.  I recommend blocking out short time blocks and taking notes along the way.  

Feel free to reach out to me on LinkedIn for any questions: [Yvonne](https://www.linkedin.com/in/yvonne-young)

