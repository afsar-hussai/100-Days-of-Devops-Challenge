# 🚀 100 Days of DevOps Challenge

Welcome to my journey of mastering DevOps! I am documenting my daily learning, labs, and projects as I progress from a fresh graduate to a skilled DevOps Engineer.

## 🎯 Goal
To commit code, learn new concepts, and build projects every single day for 100 days. My focus includes **Linux, Docker, Kubernetes, Ansible, Terraform, and CI/CD pipelines**.

---

## 📚 Progress Log

| Day | Topic | Key Learning | Status | Link |
| :---: | :--- | :--- | :---: | :--- |
| **01** | **Linux User Setup with Non-Interactive Shell** | `useradd -s /sbin/nologin`, preventing interactive logins for service accounts | ✅ | [View Notes](./Day_1_Linux_User_Setup_with_Non-Interactive_Shell) |
| **02** | **Temporary User Setup with Expiry** | `useradd -e YYYY-MM-DD`, `chage -l`, managing account lifecycles | ✅ | [View Notes](./Day_2_Temporary_User_Setup_with_Expiry) |
| **03** | **Secure Root SSH Access** | `PermitRootLogin no` in `sshd_config`, service hardening, `systemctl restart sshd` | ✅ | [View Notes](./Day_3_Secure_Root_SSH_Access) |
| **04** | **Script Execution Permissions** | Scripts need Read (r) + Execute (x) permission | ✅ | [View Notes](./Day_4_Script_Execution_Permissions) |
| **Day 5** | SELinux Config | Installed `selinux-policy` and learned to permanently disable SELinux by editing `/etc/selinux/config` (changing `enforcing` to `disabled`). | ✅ | [View Notes](./Day_5_SElinux_Installation_and_Configuration) |
| **Day 6** | Cron Jobs | Installed `cronie` package, used `crontab -e` to schedule tasks, and learned to verify execution via `systemctl status` when system logs are missing. | ✅ | [View Notes](./Day_6_Create_a_Cron_Job) |
| **07** | **Linux SSH Authentication** | `ssh-copy-id` for password-less login, resolving user-server mapping errors, and strict permission math (600/700) | ✅ | [View Notes](./Day_7_Linux_SSH_Authentication) |
| **08** | **Ansible Installation & Python Modules** | Using `python3 -m pip` to fix sudo PATH issues, pinning versions (`==`), Global vs Local installation | ✅ | [View Notes](./Day_8_Installing_Ansible) |

*(I will update this table daily with links to my notes)*

---

## 🛠️ Tech Stack & Tools
These are the technologies I will be covering during this challenge:
* **OS:** Linux (CentOS/Ubuntu)
* **Containerization:** Docker
* **Orchestration:** Kubernetes
* **Infrastructure as Code:** Terraform
* **CI/CD:** Jenkins / GitHub Actions
* **Cloud:** AWS

## 📂 Repository Structure
This repository is organized day-by-day. Inside each folder, you will find:
* `README.md`: Detailed notes on what I learned.
* **Scripts/Config Files**: The actual code I wrote.
* **Screenshots**: Visual proof of the labs I completed.

## 🔗 Connect with Me
I post daily updates about this challenge on LinkedIn.
* **LinkedIn:** [click here](https://www.linkedin.com/in/mohdafsarhussain/)
* **Twitter/X:** [click here](https://x.com/AFSARHU97849211)

---
*Started on: December 30, 2025*