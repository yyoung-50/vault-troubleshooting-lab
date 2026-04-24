
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

**Reproduce the issue**

1. Enable the Transit secrets Engine:

```bash
vault secrets enable transit
```

2. Create a key:

```bash
vault write -f transit/keys/app-key
```
3. Encrypt some data:

```bash 
vault write -format=json transit/encrypt/app-key \ 
  plaintext=$(echo -n "hello" | base64) \
  | jq -r '.data.ciphertext' > ciphertext.txt
```
4. Corrupt the ciphertext:

```bash
echo "corrupted" > ciphertext.txt
```

5. Try to decrypt:

```bash
vault write transit/decrypt/app-key ciphertext="$(cat ciphertext.txt)"
```

Command failed because ciphertext has invalid data
screen

**Diagnose the Problem**

Check:

- Is the ciphertext intact?

- Was the key rotated?

- Is the correct key name used?

**Identify the Root Cause**

- Ciphertext was corrupted or modified.

- Or wrong key name / version used.

**Apply the Fix**

Regenerate the "ciphertext" file

```bash
vault write -format=json transit/encrypt/app-key \
  plaintext=$(echo -n "hello" | base64) \
  | jq -r '.data.ciphertext' > ciphertext.txt
  ```
Run the decrypt command:

```bash
vault write transit/decrypt/app-key ciphertext="$(cat ciphertext.txt)"
```
The command was successful as the encrypted data was valid.
screen
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