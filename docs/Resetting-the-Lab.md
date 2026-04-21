
## Resetting the Lab
---

- To ensure consistent results, run the reset script before starting a new scenario.

- The rest sequence removes the running container, clears Vault’s data directory, and recreates a fresh Vault instance.

To reset the lab run the **reset-lab.sh** script from the vault-troubleshooting-lab folder.

Run the command:
```bash
./reset-lab.sh
```
After you run this script, then run these two commands:
```bash
export VAULT_ADDR="http://127.0.0.1:8200"
vault status
```
From here you are ready to practice on the troubleshooting scenarios located here: [Troubleshooting Scenarios](scenarios/)

Instructions to use this lab are here: [How to Use this Lab](docs/How-to-Use-this-Lab.md)

## Below is a detailed description of the **reset-lab.sh** script

---

### 1. Stop and remove the current environment

```bash
docker-compose down
docker rm -f vault-lab 2>/dev/null
```
- docker-compose down stops the stack and removes the project network.

- docker rm -f vault-lab ensures no leftover or ghost Vault container remains.

### 2. Reset Vault’s data directory
```bash
rm -rf ./data/*

```
This lab uses a bind mount:

```bash
./data:/vault/data
```
Because of this, Vault’s storage backend lives on your host filesystem.
Removing **./data** is what actually resets Vault’s state.

### 3. Start a fresh Vault instance
Recreates the Vault container with an empty data directory.

```bash
docker-compose up -d
```
### 4. Initialize and unseal Vault

```bash
./setup/init-vault.sh
```
This script:

- Initializes Vault
- Unseals Vault
- Saves unseal keys and the root token to init.txt
- Applies the initial setup required for the scenarios
- After this step, Vault is ready for any scenario in the lab.

### 5. Configure the Vault CLI

```bash
export VAULT_ADDR="http://127.0.0.1:8200"
vault status
```
Setting **VAULT_ADDR** ensures the CLI communicates with the running Vault instance.

### 5. Confirm that Vault is reachable

```bash
vault status
```







