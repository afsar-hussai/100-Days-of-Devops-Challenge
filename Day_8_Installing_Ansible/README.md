# 🚀 Learning Ansible: Modules, Plays, and Tasks

**Date:** January 06, 2026  
**Topic:** Ansible Basics, Multi-OS Configuration, and Playbook Architecture  
**Status:** #100DaysOfDevOps

---

## 📖 Overview
Today I explored the core architecture of Ansible, focusing on how it differs from traditional scripting (Docker/Shell). The key realization is moving from an **Imperative** mindset ("Run this command") to a **Declarative** mindset ("Ensure this state exists").

## 🧠 Key Concepts

### 1. Declarative vs. Imperative
* **Shell/Docker (Imperative):** We explicitly list commands (`yum install nano`). If run twice, it might error out or reinstall.
* **Ansible (Declarative):** We define the *end result*.
    ```yaml
    state: present
    ```
    Ansible checks if the software is already there. If yes, it does nothing (Idempotency). If no, it installs it.

### 2. The Power of Modules
Instead of writing raw Linux commands, Ansible uses **Modules** as abstractions.
* **`yum`**: Specifically for RedHat/CentOS systems.
* **`apt`**: Specifically for Debian/Ubuntu systems.
* **`package`**: A generic module that auto-detects the OS and uses the correct package manager.

---

## 💻 Code Snippets & Learnings

### 1. The Basic Playbook Structure
Understanding the hierarchy: **Playbook > Play > Task**.

* **Play:** Maps a group of `hosts` to a list of tasks (The "Where").
* **Task:** Defines the action using a module (The "What").

```yaml
---
- name: Setup Linux Hosts  # <--- The Play
  hosts: linux             # <--- Target Group
  tasks:
    - name: Ensure nano is installed  # <--- The Task
      yum:
        name: nano
        state: present
```
## 2. Handling Different Operating Systems (The Smart Way)
How do we write one code for both Ubuntu and CentOS?

**Option A:** The Generic package Module Best for packages with the same name (e.g., git, nano, curl).

```yaml
- name: Install nano generically
  package:
    name: nano
    state: present
```
**Option B:** Using when Conditionals Best when package names differ (e.g., Apache is httpd on CentOS vs apache2 on Ubuntu). Ansible uses gathered Facts to decide.

```yaml
- name: Install Apache on CentOS
  yum:
    name: httpd
    state: present
  when: ansible_os_family == "RedHat"

- name: Install Apache on Ubuntu
  apt:
    name: apache2
    state: present
  when: ansible_os_family == "Debian"
  ```

## 3. Why name: is Mandatory
In the task definition, the name parameter is required by the module to know what to target.

* Incorrect:

```yaml
yum: 
  state: present # Error: Install what?
```
* Correct:

```yaml
yum:
  name: nano     # Target defined
  state: present
```
## 📝 Terminology
| Term | Definition |
| :--- | :--- |
| **Playbook** | The YAML file containing one or more plays. |
| **Play** | A mapping between a set of hosts and the tasks to run on them. |
| **Task** | A single action (install package, copy file, start service). |
| **Module** | The code logic (usually Python) that Ansible executes on the node (e.g., `yum`, `user`, `service`). |
| **Idempotency** | The ability to run the same script multiple times without changing the result if the system is already in the desired state. |
---
# 🚀 Learning Ansible: Installation Strategies & Python Modules

**Date:** January 07, 2026  
**Topic:** Installing Ansible via Pip, System Paths, and Python Modules  
**Status:** #100DaysOfDevOps

---

## 📖 Overview
Today's challenge (KodeKloud Day 8) shifted focus from using Ansible to **installing** it under strict constraints. I learned that OS package managers (`yum`/`apt`) often lack specific or newer versions of tools. The solution lies in using **Language Package Managers** (like `pip` for Python). 

The biggest takeaway was debugging the `command not found` error when using `sudo`, leading to a deeper understanding of Linux **PATHs** and Python execution flags.

## 🧠 Key Concepts

### 1. OS Repos vs. Language Repos
* **`yum`/`apt` (OS Repos):** Great for system stability, but often outdated. They install what the Linux distribution *thinks* you should have.
* **`pip` (Python Repo):** Allows granular control. We can pin specific versions (e.g., `ansible==4.9.0`) that might not exist in the OS repo.

### 2. The `sudo` PATH Trap
When running `pip3 --version` as a regular user (`thor`), it works because the binary is in the user's **PATH**.
* **The Issue:** When switching to `root` (via `sudo`), the PATH resets for security. Root often doesn't know where the user's `pip3` executable is located.
* **The Result:** `sudo pip3 install ...` fails with "command not found".

### 3. The Power of `python3 -m pip`
Instead of relying on a shortcut (executable file) that might be missing from the PATH, we can ask the Python interpreter directly.
* **`-m` (Module):** Tells Python: *"Don't look for a script file. Look inside your internal library for a module named 'pip' and run it."*
* Since `sudo` always knows where `python3` is, this bridges the gap securely.

---

## 💻 Code Snippets & Learnings

### 1. The "Path Trap" Error
Trying to use pip directly with sudo often fails on Jump Hosts.

```bash
thor@jumphost ~$ sudo pip3 install ansible==4.9.0
# Output: sudo: pip3: command not found
```

## 2. The Robust Solution (Calling the Module)
Bypassing the shell environment by invoking the module directly through the interpreter.

```bash
# Syntax: sudo [Interpreter] -m [Module] [Command]
sudo python3 -m pip install ansible==4.9.0
```
## 3. Verifying Installation
Checking that the installation is "Global" (in /usr/local/bin) and not local to the user.
```bash
ansible --version
# Output should show:
# ansible [core 2.11.x] 
# config file = None
# python version = 3.9.x
```
---
## 🙌 Credits & Resources
Learning guided by content from:

* NetworkChuck

* Abhishek Veeramalla

* Piyush Sachdeva

* Hitesh Choudhary
