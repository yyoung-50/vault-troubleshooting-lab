## Environment Setup for Vault

**1. System Requirements**

**You will need:**

- Windows 10/11, macOS, or Linux

- Docker Desktop (Windows/macOS) or Docker Engine + Compose (Linux)

- **VS Code** (recommended)

- A terminal environment (PowerShell, Bash, or VS Code terminal)

- **jq** installed - https://stedolan.github.io/jq/download/

- **Vault CLI tool** (See Step 7 below to install the Vault binary)

---
**About the `jq` tool**

**jq** is a JSON parsing tool used to read Vault's JSON output.
If you run "jq ." and get "bash: jq:  command not found", you need to install it.

To install jq

1. Download the jq-win64.exe
2. Rename it from jq-wind64.exe to jq.exe
3. Move it to C:\Windows\System32
4. Close and reopen VS Code
5. Verify by running command "jq --version" 

---
**2. Install Docker**

**Windows 10/11**

- Install **Docker Desktop for Windows:**

- Download from: https://www.docker.com/products/docker-desktop 

- Enable WSL 2 when prompted

- Restart your machine after installation

**Docker Desktop includes:**

- Docker Engine

- Docker Compose

- Docker CLI

- Kubernetes (optional)

No additional configuration is required.

---
**macOS**

**Install Docker Desktop for Mac:**

- Download from: https://www.docker.com/products/docker-desktop 

- Drag into Applications

- Launch Docker Desktop

Docker Compose is included automatically.

---
**Linux (Ubuntu/Debian/Fedora/etc.)**
Install Docker Engine + Docker Compose plugin:

```bash
sudo apt update
sudo apt install docker.io docker-compose-plugin -y
```
Enable non‑root access:

```bash
sudo usermod -aG docker $USER
```
Sign out and sign back in.

---

**3. Verify Docker Installation**

Run the following commands:

```bash
docker --version
docker compose version
docker run hello-world
```
You should see a confirmation message from Docker.

---

**4. Install Visual Studio Code (Recommended)**
- Download VS Code:  see https://code.visualstudio.com/

- Install recommended extensions:

  - Container Extension (Optional)
    - Helps visualize containers, images, logs, and networks


---
**5. Verify VS Code Can Connect to Docker**

After installing the Container Extension test the connection to Docker.

- Open VS Code and check the left sidebar:

- You should see a Container icon

- Clicking it should show:

  - Containers
  - Images
  - Registries
  - Networks
  - Volumes
  - Docker Contexts

If you see these, VS Code is successfully connected to the Docker daemon.

---

**6. Terminal Options**

You can run the lab from:

- VS Code integrated terminal

- PowerShell

- Windows Terminal

- macOS Terminal

- Linux shell

All commands in the lab work the same across environments.

---
**7. Install the Vault CLI** - https://developer.hashicorp.com/vault/docs/get-vault/install-binary

- The Vault CLI runs locally on your machine and communicates with the Vault server running in Docker.

- Vault CLI is downloaded as a single binary called **Vault**

- The following are the installation methods for your operating system.

**Windows (Chocolatey)**

PowerShell (Run as Administrator)

```powershell
choco install vault
```
**macOS (Homebrew)**

```bash
brew install vault
```

**Linux (Debian/Ubuntu)**

```bash
sudo apt update
sudo apt install vault
```

**Verify Installation**

After installation, confirm the CLI is available:

```bash
vault --version
```
**Setup Complete**

- You are now ready to run the Vault Troubleshooting Lab.

- Return to the main README and follow the steps to get started.

- You can access the Vault UI at http://localhost:8200

### Vault Initialization Script


When you run the lab reset script it configures Vault as follows:

---

| Check | Command | Expected Result |
|-------|---------|-----------------|
| Vault initialized | `vault status` | Initialized: true |
| Vault unsealed | `vault status` | Sealed: false |
| KV v2 enabled | `vault secrets list` | kv/ (kv-v2) |
| AppRole enabled | `vault auth list` | approle/ |
| Policies loaded | `vault policy list` | app-policy present |
| AppRole created | `vault list auth/approle/role` | app-role present |
| Role ID exists | `vault read auth/approle/role/app-role/role-id` | returns ID |
| Secret ID endpoint works | `vault write -f auth/approle/role/app-role/secret-id` | returns secret_id |


 - See the lab folder structure for key files -  [Lab Folder Structure](How-to-Use-this-Lab.md#lab-folder-structure)

 ## Lab Setup Script

 - The lab setup script resets the lab configurations from the initialization script (init-vault.sh)

 - If you get the error below running the lab reset script
   - Check that the container is running on Docker desktop.
   - Restart the container

  <img src="https://github.com/yyoung-50/vault-troubleshooting-lab/blob/main/screenshots/waiting-for-vault.png" width="500">

---