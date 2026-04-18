#!/usr/bin/env bash
set -euo pipefail

# ==================================================
# Vault Initialization and Configuration Script
# - Initializes Vault
# - Unseals Vault
# - Enables KV secrets engine
# - Configures AppRole authentication
# - Creates policies and sample secret
# ==================================================

# =========================
# Environment Configuration
# =========================
export VAULT_ADDR="http://127.0.0.1:8200"

# =========================
# Check for Dependencies
# =========================
if ! command -v jq &> /dev/null; then
  echo "[ERROR] jq is required but not installed."
  exit 1
fi

# =========================
# Wait for Vault to be Ready
# =========================
until curl -s http://127.0.0.1:8200/v1/sys/health > /dev/null; do
  echo "[*] Waiting for Vault..."
  sleep 2
done

# =========================
# Initialize Vault
# =========================
echo "[*] Initializing Vault..."
vault operator init -key-shares=1 -key-threshold=1 > init.txt

# =========================
# Vault is not ready.
# =========================
if [[ ! -s init.txt ]]; then
  echo "[ERROR] init.txt is empty. Vault is not ready."
  exit 1
fi

# =========================
# Extract Credentials
# =========================
UNSEAL_KEY=$(grep 'Unseal Key 1:' init.txt | awk '{print $4}')
ROOT_TOKEN=$(grep 'Initial Root Token:' init.txt | awk '{print $4}')

# =========================
# Unseal Vault
# =========================
echo "[*] Unsealing Vault..."
vault operator unseal "$UNSEAL_KEY"

# =========================
# Authenticate with Root Token
# =========================
export VAULT_TOKEN="$ROOT_TOKEN"

# =========================
# Configure Secrets Engine
# =========================
echo "[*] Enabling KV v2 at path 'kv'..."
vault secrets enable -path=kv kv-v2

# =========================
# Enable Authentication Method
# =========================
echo "[*] Enabling AppRole auth..."
vault auth enable approle

# =========================
# Apply Access Policies
# =========================
echo "[*] Writing policies..."
vault policy write app-policy ./setup/policies/app-policy.hcl
vault policy write admin-policy ./setup/policies/admin-policy.hcl

# =========================
# Create AppRole
# =========================
echo "[*] Creating AppRole 'app-role'..."
vault write auth/approle/role/app-role \
  token_policies="app-policy" \
  secret_id_ttl=60m \
  token_ttl=30m \
  token_max_ttl=60m

# =========================
# Store Sample Secret
# =========================
echo "[*] Storing sample secret at kv/app/config..."
vault kv put kv/app/config api_key="super-secret-api-key" env="dev"

# =========================
# Retrieve AppRole Credentials
# =========================
echo "[*] Fetching AppRole credentials..."

vault read -format=json auth/approle/role/app-role/role-id \
  | jq -r '.data.role_id' > setup/roles/app-role-id.txt

vault write -format=json -f auth/approle/role/app-role/secret-id \
  | jq -r '.data.secret_id' > setup/roles/app-secret-id.txt

# =========================
# Output Summary
# =========================
echo "[*] Setup complete."
echo "Unseal key:  $UNSEAL_KEY"
echo "Root token:  $ROOT_TOKEN"
echo "Role ID:     $(cat setup/roles/app-role-id.txt)"
echo "Secret ID:   $(cat setup/roles/app-secret-id.txt)"

