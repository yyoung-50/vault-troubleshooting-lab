#!/usr/bin/env bash

echo "Resetting Vault lab..."

# Stop and clean
docker-compose down -v
rm -rf ./data/*
rm -f ./init.txt
rm -f ./setup/roles/*.txt

# Start Vault
docker-compose up -d

echo "Waiting for Vault to start..."
sleep 3

# Initialize + unseal
./setup/init-vault.sh

# Export environment variables (IMPORTANT)
export VAULT_ADDR="http://127.0.0.1:8200"

# Extract root token automatically
export VAULT_TOKEN=$(grep 'Initial Root Token:' init.txt | awk '{print $4}')

echo "Fresh Vault environment ready"
echo "VAULT_ADDR=$VAULT_ADDR"
echo "VAULT_TOKEN=$VAULT_TOKEN"
