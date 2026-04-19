# Top 20 Vault Commands Every Support Engineer Uses

## 1. Check Vault status
vault status

## 2. Initialize Vault
vault operator init

## 3. Unseal Vault
vault operator unseal <key>

## 4. Seal Vault
vault operator seal

## 5. Login with a token
vault login <token>

## 6. Lookup token details
vault token lookup

## 7. Renew a token
vault token renew

## 8. Check token capabilities on a path
vault token capabilities <token> <path>

## 9. List enabled secrets engines
vault secrets list

## 10. Enable a secrets engine
vault secrets enable -path=my-kv kv-v2

## 11. Disable a secrets engine
vault secrets disable my-kv/

## 12. Write a KVv2 secret
vault kv put secret/app username="admin" password="pass123"

## 13. Read a KVv2 secret
vault kv get secret/app

## 14. List secrets under a path
vault kv list secret/

## 15. Encrypt data with Transit
vault write transit/encrypt/my-key plaintext=$(base64 <<< "hello")

## 16. Decrypt data with Transit
vault write transit/decrypt/my-key ciphertext="vault:v1:..."

## 17. Read an AppRole’s RoleID
vault read auth/approle/role/app-role/role-id

## 18. Generate a new SecretID
vault write -f auth/approle/role/app-role/secret-id

## 19. Login with AppRole
vault write auth/approle/login role_id="$ROLE_ID" secret_id="$SECRET_ID"

## 20. Read a policy
vault policy read <policy-name>
