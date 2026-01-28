* * * * *

🚀 Day 10: Automated Website Backup Script
==========================================

### 100 Days of DevOps Challenge (KodeKloud)

📝 Project Overview
-------------------

The goal of this task was to automate the backup process for a static website hosted on **App Server 1** within the Stratos Datacenter. The script handles file compression, local storage, and secure remote transfer to the **Nautilus Backup Server** without manual intervention.

* * * * *

🛠️ Tech Stack & Tools
----------------------

-   **Scripting:** Bash (Bourne Again Shell) 🐚

-   **Compression:** Zip Utility 🤐

-   **Security:** SSH & SCP (Secure Copy Protocol) 🔐

-   **Environment:** Linux (CentOS/Ubuntu) 🐧

* * * * *

📖 What I Learnt
----------------

-   **Bash Automation:** How to use variables and absolute paths to make scripts reusable and less prone to errors.

-   **Compression Logic:** Using the `-r` (recursive) flag with `zip` to ensure entire directory structures are preserved.

-   **Passwordless Authentication:** Mastering `ssh-keygen` and `ssh-copy-id` to allow servers to "trust" each other---a fundamental concept in CI/CD and automation.

-   **Secure Transfers:** Using `scp` to move data across the network securely.

* * * * *

🚧 Challenges & Solutions
-------------------------

### 1\. The Password Prompt 🔑

-   **Challenge:** The script was stopping and asking for a password when trying to copy the file to the Nautilus server. In automation, there is no one to type the password!

-   **Resolution:** I generated an RSA key pair on App Server 3 and shared the public key with the Nautilus Backup Server. Now, they communicate via a "digital handshake."

### 2\. The "No Sudo" Constraint 🚫

-   **Challenge:** The task explicitly forbid using `sudo` inside the script. This meant all permissions had to be handled beforehand.

-   **Resolution:** I manually installed the `zip` package as a prerequisite and ensured the user executing the script had ownership of the `/scripts` and `/backup` directories.

### 3\. Missing Dependencies 📦

-   **Challenge:** The `zip` command wasn't available by default on the server.

-   **Resolution:** Identified the OS and used the appropriate package manager (`yum`) to install the utility before running the script.

* * * * *

🚀 How to Run
-------------

1.  **Clone the script** to `/news_backup.sh`.

2.  **Give execution rights:** `chmod +x /news_backup.sh`.

3.  **Run the magic:** `./news_backup.sh`.

* * * * *

✅ Final Result
--------------

-   [x] Website media compressed into `xfusioncorp_news.zip`.

-   [x] Local copy stored in `/backup/`.

-   [x] Remote copy successfully moved to **Nautilus Backup Server**.

-   [x] Zero manual passwords entered! 🎉