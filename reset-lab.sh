#!/bin/bash

# Stopping Vault container
docker-compose down

# Removing old Vault container if exists
docker rm -f vault-lab 2>/dev/null

# Cleaning Vault data directory and generated credentials
rm -rf ./data/*
rm -f ./init.txt
rm -f ./setup/roles/app-role-id.txt
rm -f ./setup/roles/app-secret-id.txt

# Starting fresh Vault container
docker-compose up -d

# Reinitializing and unsealing Vault
./setup/init-vault.sh

