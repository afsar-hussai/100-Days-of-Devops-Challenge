# Day 4: Linux File Permissions & Script Execution

**Challenge:** 100 Days of DevOps (KodeKloud)  
**Project:** Nautilus (xFusionCorp)  
**Date:** 2026-01-02  

## 📋 Task Description
The xFusionCorp sysadmin team distributed a backup script named `xfusioncorp.sh` to all servers. However, on **App Server 2**, the script lacked the necessary permissions. The requirement was to:
1. Locate the script at `/tmp/xfusioncorp.sh`.
2. Grant **executable** permissions to the script.
3. Ensure **all users** on the system have the capability to execute it.

## 🛠️ Implementation & Troubleshooting

### 1. Initial Assessment
I logged into `stapp02` and checked the file's current status:
```bash
ssh steve@stapp02
ls -l /tmp/xfusioncorp.sh
# Output: ---------- 1 root root ... (No permissions set)
```

## 2. The Challenge (The "Gotcha")
My initial thought was to simply add executable permissions (+x).

```bash
sudo chmod +x /tmp/xfusioncorp.sh
```
**Result:** The file permissions became ---x--x--x. Issue: While the file was marked "executable," the shell failed to run it. Root Cause: Unlike compiled binaries, a Bash script is a text file. For the shell to execute it, it must be able to read the commands inside the file. Giving only execute (x) permission without read (r) permission caused the script to fail.

## 3. The Solution
I corrected the permissions to ensure all users could both Read and Execute the script.

```bash
sudo chmod +rx /tmp/xfusioncorp.sh
```
Final Permissions: r-xr-xr-x

## 4. Verification Strategy
To ensure the "all users" requirement was truly met, I performed a manual test:

Created a temporary test user named ashu.

Switched to that user.

Attempted to run the script.

```bash

sudo useradd ashu
su - ashu
/tmp/xfusioncorp.sh
# Result: Script executed successfully.
```
## 🧠 Key Learnings
Scripts vs. Binaries: Scripts require r (read) permission to execute because the interpreter needs to read the file content.

Chmod Shorthand: Using a+rx (All users + Read/Execute) is a quick way to ensure global access.

Verification: Checking permissions with ls -l is good, but testing with a different user account confirms the configuration actually works.