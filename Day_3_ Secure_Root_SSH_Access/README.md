# Day 03: SSH Hardening & Service Management

**Date:** 2026-01-02
**Project:** Stratos Datacenter Security Hardening (xFusionCorp)

## 📝 Project Description
Today's task involved securing the App Servers (`stapp01`, `stapp02`, `stapp03`) by disabling direct root login. This is a critical security compliance step to prevent brute-force attacks on the administrative account.

The goal was to modify the SSH Daemon configuration so that no one—not even the administrator—can log in remotely as `root`. Users must log in as a regular user (e.g., `tony`) and escalate privileges using `sudo`.

## 🛠️ Technical Steps

### 1. Edit the Configuration
I modified the main SSH configuration file on all three servers.
```bash
sudo vi /etc/ssh/sshd_config
```

**Change made:** Found the line #PermitRootLogin yes and changed it to:

```bash
PermitRootLogin no
```

### 2. Restart the Service (The Critical Step)

For the changes to take effect, the SSH Daemon must be restarted.

```bash

sudo systemctl restart sshd
```
### 3. Verification

I verified the configuration was active using the test mode command:

```bash

sudo sshd -T | grep permitrootlogin
# Expected Output: permitrootlogin no
```

## 🚧 Challenges Faced (Debugging Journey)

**The Issue:**
After editing the `/etc/ssh/sshd_config` file and saving it, I tried to verify if the root login was blocked. To my surprise, **root login was still working**. The server was completely ignoring my changes.

**The Debugging Process:**
1.  I checked the file again (`cat /etc/ssh/sshd_config`) to make sure I saved it. The file was correct (`PermitRootLogin no`).
2.  I checked if the service was running (`sudo systemctl status sshd`). It was active.
3.  **The "Aha!" Moment:** I realized that Linux **Daemons** (background services) load their configuration into memory only when they start. Since I hadn't restarted the service, the daemon was still using the "old" configuration it read days ago.

**The Resolution:**
I ran the restart command:
```bash
sudo systemctl restart sshd
```

After this, the restriction worked immediately.

## 🧠 Key Learnings
* **Daemons vs. Config Files:** Changing a file on the disk doesn't change the running process. You must always signal the daemon (`restart`/`reload`) to pick up changes.
* **Verification:** Using `sshd -T` is safer than just reading the file because it shows what the server is *actually* enforcing.
* **Security Best Practices:** Disabling direct root access ensures audit trails, as every action can be traced back to a specific user (e.g., `tony`) via `sudo` logs.

## 🔗 References
* [Linux Systemctl Guide](https://man7.org/linux/man-pages/man1/systemctl.1.html)
* [OpenSSH Configuration Manual](https://man.openbsd.org/sshd_config)
