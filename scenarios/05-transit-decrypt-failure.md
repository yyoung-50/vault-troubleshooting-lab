
---

## Ticket # 456705  - Transit Decrypt Failure

```markdown
# Scenario 05 – Transit Decrypt Failure

## Summary

An application can encrypt data using the Transit engine but fails to decrypt it.

---

## Symptoms

- `vault write transit/decrypt/...` fails.

## Error Output
- Error mentions invalid ciphertext or key version.
- Encryption appears to work fine.
```
1. Ensure Vault is running and initialized:

- This step assumes you ran the **reset-lab.sh** script.  See steps to run script: [Lab Setup Script](../README.md#4-run-the-lab-setup-script)
- After running the reset script, save the output to use the **Root token** in later exercises.

**Reproduce the issue**

1. Enable the Transit secrets Engine:

Run:
```bash
vault secrets enable transit
```

2. Create a key:

Run:
```bash
vault write -f transit/keys/app-key
```
Output confirms key was created:

<img src="https://github.com/yyoung-50/vault-troubleshooting-lab/blob/main/screenshots/scenario01/transit-encryption-key.png" width="500">

3. Encrypt some data:

```bash 
vault write -format=json transit/encrypt/app-key \
  plaintext=$(echo -n "hello" | base64) \
  | jq -r '.data.ciphertext' > ciphertext.txt
```
Output from this command creates a file called "ciphertext.txt" in your current directory.

4. Corrupt the ciphertext:

Run:
```bash
echo "corrupted" > ciphertext.txt
```

5. Run decrypt command:

```bash
vault write transit/decrypt/app-key ciphertext="$(cat ciphertext.txt)"
```

Command failed because ciphertext has invalid data

<img src="https://github.com/yyoung-50/vault-troubleshooting-lab/blob/main/screenshots/scenario01/cannot-decrypt.png" width="500">

**Diagnose the Problem**

Verify the following:

- Is the ciphertext intact?

- Was the key rotated?

- Is the correct key name used?

**Identify the Root Cause**

- Ciphertext was corrupted or modified.

- Or wrong key name / version used.

**Apply the Fix**

Regenerate the "ciphertext" file

Run:
```bash
vault write -format=json transit/encrypt/app-key \
  plaintext=$(echo -n "hello" | base64) \
  | jq -r '.data.ciphertext' > ciphertext.txt
  ```

Run the decrypt command:

```bash
vault write transit/decrypt/app-key ciphertext="$(cat ciphertext.txt)"
```
The decryption was successful as the encrypted data was valid.

<img src="https://github.com/yyoung-50/vault-troubleshooting-lab/blob/main/screenshots/scenario01/decyrpt-successful.png" width="500">

Recommended solutions:

- Use the original, unmodified ciphertext.

- Ensure the correct key name and version.

**Key Takeaways**

- Transit is sensitive to ciphertext integrity.

  - Ask for the exact ciphertext used.

  - Verify key name and rotation status.

---

After you complete a scenario run the setup script: [Lab Setup Script](../README.md#4-run-the-lab-setup-script)

You are now ready to go to the next scenario file: