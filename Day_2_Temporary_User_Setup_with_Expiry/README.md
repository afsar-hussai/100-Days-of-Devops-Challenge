# Day 2: Linux User Management & Account Expiration 🐧

**Date:** 2026-01-02
**Platform:** KodeKloud (100 Days of DevOps Challenge)
**Topic:** Linux System Administration - User Management

---

## 🚀 Overview
On Day 2, I focused on advanced user creation and verification in Linux. Specifically, I learned how to create users with temporary access (expiration dates) and how to audit user account details to ensure security policies are met.

## 🧠 What I Learned

### 1. Creating a User with an Expiration Date
In many production environments, we need to give temporary access to contractors or developers. Instead of remembering to delete the account, we can set it to expire automatically.

* **Command:** `useradd -e YYYY-MM-DD <username>`
* **Flag:** `-e` stands for "expire date".

### 2. Verifying User Existence
Before performing actions on a user, it is best to verify they exist and check their User ID (UID) and Group ID (GID).

* **Command:** `id <username>`
* **Behavior:** Returns the user's identity details or "no such user" if they don't exist.

### 3. Checking Account Aging & Expiration Details
To verify if the expiration date was set correctly or to see when a password expires, we use the `chage` (change age) command.

* **Command:** `chage -l <username>`
* **Flag:** `-l` stands for "list".

---

## 🛠️ Commands Reference

```bash
# 1. Create a user 'jane' that expires on Jan 30th, 2026
sudo useradd -e 2026-01-30 jane

# 2. Check if the user 'jane' was created successfully
id jane

# 3. Verify the account expiration date is set correctly
sudo chage -l jane

```

---

## ⚠️ Challenges Faced & Debugging

### Challenge 1: "Permission Denied" Error
**Issue:**
When I first tried to run `useradd -e 2026-01-30 temp_user`, I received a `Permission denied` or `lock file` error.

**Debugging & Resolution:**
* **Reasoning:** I realized that adding users modifies system files (like `/etc/passwd` and `/etc/shadow`), which requires root privileges.
* **Fix:** I prepended `sudo` to the command.

```bash
sudo useradd -e 2026-01-30 temp_user
```
### Challenge 2: Verifying the Expiry Date
**Issue:**
After creating the user, I used the standard `id` command, but it didn't show me *when* the account would expire, only the UID and GID. I wasn't sure if the `-e` flag actually worked.

**Debugging & Resolution:**
* **Reasoning:** The `id` command only shows identity, not account aging policies. I needed a command specific to account lifecycle.
* **Search:** I looked up how to list password and account expiry info.
* **Fix:** I found the `chage` command. Using `sudo chage -l <username>` clearly listed "Account expires: Jan 30, 2026", confirming the setup was correct.

## 📝 Key Takeaways
* Always use `sudo` for user management.
* The date format for expiration must be **YYYY-MM-DD**.
* `id` is for identity checks; `chage -l` is for policy/time checks.

#100DaysOfDevOps #Linux #KodeKloud #DevOpsJourney