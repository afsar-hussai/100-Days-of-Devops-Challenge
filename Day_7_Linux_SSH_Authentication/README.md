# Day 7: Linux SSH Authentication & Troubleshooting

**Challenge:** Configure password-less SSH access for a specific user across a multi-server architecture.

## 🚀 The Task
The goal was to allow the user `thor` on a **Jump Host** to SSH into three distinct application servers without entering a password. This is a foundational skill for automation (Ansible, Jenkins, scripting) where human intervention isn't possible.

## 🧠 Key Learnings

### 1. SSH Key Architecture
I learned that SSH uses asymmetric encryption involving a key pair:
- **Private Key (`id_rsa`):** Kept secure on the source machine (Jump Host).
- **Public Key (`id_rsa.pub`):** The "lock" that gets installed on the destination servers.

### 2. The `ssh-copy-id` Utility
Instead of manually copying and pasting keys (which is prone to errors), I used `ssh-copy-id user@host`. This command:
- Connects to the remote server.
- Appends my public key to the `~/.ssh/authorized_keys` file.
- Automatically handles directory creation if needed.

### 3. Linux Permissions Math (Revisted)
I did a deep dive into *why* SSH is so strict about permissions. If the permissions are too open, SSH ignores the keys for security.
- **Read (4) + Write (2) + Execute (1)**
- **Folder (`~/.ssh`) -> 700:** Owner needs `rwx` (to enter the folder), but Group/Others get `0`.
- **File (`authorized_keys`) -> 600:** Owner needs `rw-` (to read/write), but no execution is needed, and Group/Others must be blocked.

---

## 🛑 Challenges & Troubleshooting

### The "Permission Denied" Trap
After setting up the first user (`tony`), I tried to verify the second user (`steve`) but hit a wall:

```bash
thor@jumphost ~$ ssh steve@stapp01
steve@stapp01's password: 
Permission denied, please try again.
```

### The Debugging Process:

1. I checked if the key was generated correctly (it was).
2. I realized I was trying to log in as `steve` on `stapp01`.
3. **Root Cause:** In this architecture, users are mapped to specific servers. User `tony` exists on `stapp01`, but `steve` only exists on `stapp02`.
4. **The Fix:** I corrected my target hosts to match the architecture.

## 🛠️ Command Log

```bash
# 1. Switch to the correct user (NEVER run as root if the task belongs to a user)
su - thor

# 2. Generate the Key Pair (Empty passphrase for automation)
ssh-keygen -t rsa

# 3. Copy keys to the correct respective servers
ssh-copy-id tony@stapp01
ssh-copy-id steve@stapp02
ssh-copy-id banner@stapp03

# 4. Verify connectivity
ssh tony@stapp01  # Success!
```


## 🧠 Key Learnings

### 1. SSH Key Architecture
I learned that SSH uses asymmetric encryption involving a key pair:
- **Private Key (`id_rsa`):** Kept secure on the source machine (Jump Host).
- **Public Key (`id_rsa.pub`):** The "lock" that gets installed on the destination servers.

### 2. The `ssh-copy-id` Utility
Instead of manually copying and pasting keys (which is prone to errors), I used `ssh-copy-id user@host`. This command:
- Connects to the remote server.
- Appends my public key to the `~/.ssh/authorized_keys` file.
- Automatically handles directory creation if needed.

### 3. Linux Permissions Math (Revisited)
I did a deep dive into *why* SSH is so strict about permissions. If the permissions are too open, SSH ignores the keys for security.
- **Read (4) + Write (2) + Execute (1)**
- **Folder (`~/.ssh`) -> 700:** Owner needs `rwx` (to enter the folder), but Group/Others must get `0`.
- **File (`authorized_keys`) -> 600:** Owner needs `rw-` (to read/write), but no execution is needed, and Group/Others must be blocked.

---
*Part of my 100 Days of DevOps journey.*