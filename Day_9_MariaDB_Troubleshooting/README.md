# 🐚 Day 9: Basics of Bash Scripting
## 100 Days of DevOps Challenge (KodeKloud)

### 📋 Overview
Today's focus is on moving from executing manual commands to automating workflows using Bash scripts. This repository contains the foundational scripts created during Day 9 of the KodeKloud DevOps challenge.

---

### 🧠 Key Concepts Covered
* **The Shebang (`#!`):** Telling the kernel which interpreter to use (e.g., `#!/bin/bash`).
* **Execution Permissions:** Using `chmod +x` to make scripts runnable.
* **Variables:** Defining and referencing local and environment variables.
* **User Input:** Making scripts interactive using the `read` command.
* **Positional Parameters:** Handling arguments passed at runtime (`$1`, `$2`, etc.).
* **Command Substitution:** Capturing the output of a command inside a variable using `$(command)`.

---

### 🚀 Getting Started

#### 1. Script Structure
Every script starts with the shebang to ensure it runs in the Bash shell:
```bash
#!/bin/bash
echo "Hello, DevOps World!"
```


MariaDB Troubleshooting: Service Restoration Guide
==================================================

DevOps Challenge - Day 9
------------------------

### 📋 Scenario

The **Nautilus** application in the **Stratos DC** environment was unable to connect to the database. Upon investigation, it was discovered that the MariaDB service on the database server (`stdb01`) was down, causing a critical production outage.

### 🛠 Tools Used

-   **Systemd**: For service management (`systemctl`).

-   **Journalctl**: For deep log analysis and debugging.

-   **Linux Permissions**: To fix ownership issues (`chown`).

-   **MariaDB CLI**: For final connection verification.

* * * * *

### 🚀 Troubleshooting Workflow

#### 1\. Identification

Start by checking the current state of the service to confirm it is inactive or failed.

Bash

```
sudo systemctl status mariadb

```

#### 2\. Deep Dive Logging

Use `journalctl` to find the "why" behind the failure.

Bash

```
sudo journalctl -xeu mariadb.service

```

-   **`-x`**: Provides catalog explanations for errors.

-   **`-e`**: Jumps to the end of the logs (latest events).

-   **`-u`**: Filters logs specifically for the MariaDB unit.

#### 3\. Resolving Common Issues

-   **Missing Directory:** If `/var/lib/mysql` is missing, the service cannot store data.

    Bash

    ```
    sudo mkdir -p /var/lib/mysql

    ```

-   **Permission Fixes:** MariaDB requires the `mysql` user to own the data directory.

    Bash

    ```
    sudo chown -R mysql:mysql /var/lib/mysql

    ```

    > **Note:** The `-R` flag is recursive, ensuring all sub-files and folders inherit the correct ownership.

#### 4\. Service Restoration

Reload the configuration and start the service.

Bash

```
sudo systemctl daemon-reload
sudo systemctl start mariadb
sudo systemctl enable mariadb

```

#### 5\. Verification

Verify the service is active and attempt a local login to ensure the database engine is responding to queries.

Bash

```
mysql -u root -p

```

* * * * *

### 🧠 Key Concepts Learned

-   **Service Lifecycle**: Understanding how `systemd` manages background processes.

-   **Data Persistence**: The importance of `/var/lib/mysql` as the "source of truth" for database files.

-   **Ownership vs. Permissions**: Learning that a service (like MariaDB) often runs under a specific system user (`mysql`) and cannot function if it doesn't "own" its data folders.

-   **Log Interpretation**: Using `journalctl` flags to cut through the noise and find the root cause of a crash.