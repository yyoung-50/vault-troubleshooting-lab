
## Resetting the Lab Settings
---
To reset the lab run the **reset-lab.sh** script from the vault-troubleshooting-lab folder.

Before running check that the Docker Vault container is running.
```bash
source reset-lab.sh
```

### 5. Confirm that Vault is ready

```bash
vault status
```
Vault status output will show:
Initialized: true
Sealed: false

Output for running "vault status" command

![Vault Status](https://raw.githubusercontent.com/yyoung-50/vault-troubleshooting-lab/main/screenshots/scenario01/vault-status.png)







