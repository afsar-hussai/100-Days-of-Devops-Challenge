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
## 🙌 Credits & Resources
Learning guided by content from:

* NetworkChuck

* Abhishek Veeramalla

* Piyush Sachdeva

* Hitesh Choudhary
