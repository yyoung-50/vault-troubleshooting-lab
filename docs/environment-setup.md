**📌 1. System Requirements**

**You will need:**

- Windows 10/11, macOS, or Linux

- Docker Desktop (Windows/macOS) or Docker Engine + Compose (Linux)

- VS Code (recommended)

A terminal environment (PowerShell, Bash, or VS Code terminal)
```

**2. Install Docker**

**Windows 10/11**

1. Install **Docker Desktop for Windows:**

2. Download from: https://www.docker.com/products/docker-desktop (docker.com in Bing)

3. Enable WSL 2 when prompted

4. Restart your machine after installation

**Docker Desktop includes:**

- Docker Engine

- Docker Compose

- Docker CLI

- Kubernetes (optional)

No additional configuration is required.
```

**macOS**

Install Docker Desktop for Mac:

Download from: https://www.docker.com/products/docker-desktop (docker.com in Bing)

Drag into Applications

Launch Docker Desktop

Docker Compose is included automatically.
```

Linux (Ubuntu/Debian/Fedora/etc.)
Install Docker Engine + Docker Compose plugin:

bash
sudo apt update
sudo apt install docker.io docker-compose-plugin -y
Enable non‑root access:

bash
sudo usermod -aG docker $USER

Sign out and sign back in.

3. Verify Docker Installation

Run the following commands:
```
docker --version
docker compose version
docker run hello-world
```
You should see a confirmation message from Docker.

🧰 4. Install Visual Studio Code (Recommended)
Download VS Code:

https://code.visualstudio.com/

Install recommended extensions:

Container Extension
Helps visualize containers, images, logs, and networks

HashiCorp Terraform Extension (optional)
Syntax highlighting

Formatting

IntelliSense

🔌 5. Verify VS Code Can Connect to Docker
Open VS Code and check the left sidebar:

You should see a Container icon

Clicking it should show:

Containers
Images
Registries
Networks
Volumes
Docker Contexts

If you see these, VS Code is successfully connected to the Docker daemon.
```

🧭 6. Terminal Options
You can run the lab from:

VS Code integrated terminal

PowerShell

Windows Terminal

macOS Terminal

Linux shell

All commands in the lab work the same across environments.
```

🔐 7. Optional: Install Vault CLI (Not Required)
The lab includes a Vault server running inside Docker.
You do not need Vault installed locally, but if you want the CLI:

Windows (Chocolatey)
powershell
choco install vault
macOS (Homebrew)
bash
brew install vault
Linux
bash
sudo apt install vault
```

🎉 Setup Complete
You are now ready to run the Vault Troubleshooting Lab.

Return to the main README and follow:

docker-compose up -d

./init-vault.sh

Access Vault at http://localhost:8200