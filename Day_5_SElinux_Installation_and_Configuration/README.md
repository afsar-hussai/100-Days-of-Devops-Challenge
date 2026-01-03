# Day 5: SELinux Installation and Troubleshooting 🛡️

## 📝 Challenge Description
**Scenario:** xFusionCorp Industries required a server hardening update. The task was to install **SELinux (Security-Enhanced Linux)** on a designated server and configure it to be **permanently disabled** (likely for a specific maintenance or legacy application requirement).

**Status:** ✅ Completed

---

## 🚧 Challenges Faced
The main hurdle today wasn't the configuration itself, but the **installation process**.

### 1. The "Dependency Hell"
I attempted to install all SELinux-related packages using a standard wildcard command:
```bash
yum install selinux* -y
```
**Error:** The installation failed because of conflicting dependencies. Some packages in the repository required different versions of libraries than what was available, causing the package manager to abort the entire operation.

### 2. The Solution

I learned about powerful flags in yum/dnf that allow us to bypass these strict checks when appropriate.

*   **The Fix:**

```bash
yum install selinux* -y --nobest --skip-broken
```

*   **Why it worked:**
    
    *   \--nobest: Told the system to settle for a slightly older version if the "best" (newest) one had broken dependencies.
        
    *   \--skip-broken: Told the system to ignore specific broken packages and proceed with installing the valid ones.
        

🛠️ Step-by-Step Implementation
-------------------------------

### Step 1: Verify Current State

First, I checked if SELinux was already running.

```bash
sestatus
# Output: command not found (Confirmed packages were missing)
```
**Step 2: Install Packages**
    
*   Used the "smart" install command to handle dependencies:

```bash
sudo yum install selinux* -y --nobest --skip-broken
```
**Verification:**

```bash
rpm -qa | grep selinux
# Confirmed installation of: selinux-policy, selinux-policy-targeted, policycoreutils
```
**Step 3: Configure SELinux Mode**

The task required disabling SELinux permanently. This requires editing the main configuration file.

```bash
sudo vi /etc/selinux/config
```
**Change made:**
```bash
# Changed from:
SELINUX=enforcing

# Changed to:
SELINUX=disabled
```
Note: This change applies after the next reboot.

## 🧠 Key Learnings & Concepts

### 1. What is SELinux actually?
I learned that standard Linux permissions (`rwx`) are like a **Key Card** system—if you have the key, you get in. SELinux acts like a **Security Guard** who checks a rulebook. Even if you have the key, the guard might say, *"Sorry, web servers aren't allowed in the home directory,"* and block you. It effectively contains compromised applications.

### 2. `chcon` vs `semanage`
A crucial distinction I learned today:

* **`chcon` (Change Context):** Like putting a **Sticky Note** on a door. It works instantly but gets wiped away if the file system is relabeled (e.g., by `restorecon`). Good for temporary testing.
* **`semanage` (SELinux Management):** Like updating the **Building Blueprints**. It adds a permanent rule to the policy database so the label survives system relabeling.

### 3. RPM Pipeline
I used a useful pipeline to filter installed packages:

```bash
rpm -qa | grep selinux
```


* **`rpm -qa`**: Query **All** installed packages.
* **`| grep`**: Filter the massive list for a specific keyword.

## 🔮 Next Steps
* Explore how to create custom SELinux policies.
* Practice using `restorecon` to fix label issues without disabling the entire security system.

#100DaysOfDevOps #Linux #Security #SELinux #LearningInPublic
