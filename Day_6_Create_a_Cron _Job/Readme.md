# Day 6: Automating Tasks with Cron Jobs in Linux

## 🚀 Challenge Description
The goal for today was to automate a routine task on the Nautilus App Servers. The requirement was to install the necessary packages for automation and schedule a job to run every 5 minutes using the **Cron** daemon.

**Task Requirements:**
1. Install `cronie` package on all App Servers.
2. Start the `crond` service.
3. Schedule a job for the `root` user to run `echo hello > /tmp/cron_text` every 5 minutes.

---

## 🛠️ Solution & Commands

### 1. Package Installation
On minimal Linux installs (like the Stratos DC environment), Cron is not always installed by default. We use the package manager to install it.

```bash
# Install the cronie package
sudo yum install cronie -y
```
## 2. Service Management
Installing the package doesn't start the daemon automatically. We must start it and enable it to ensure it runs.

```bash
# Start the service
sudo systemctl start crond

# Enable it (optional, ensures it starts on reboot)
sudo systemctl enable crond

# Check status
sudo systemctl status crond
```

## 3. Configuring the Schedule (Crontab)
We edit the crontab table for the specific user (root).

```bash
# Edit root's crontab
sudo crontab -u root -e
```
## The Schedule Syntax:

```bash
*/5 * * * * echo hello > /tmp/cron_text
```

* */5: Every 5 minutes (0, 5, 10, 15...)

* *: Every hour

* *: Every day of the month

* *: Every month

* *: Every day of the week


🧠 Key Learnings & "Gotchas"
----------------------------

### 1. No Restart Required

I learned that after editing the crontab using crontab -e, **you do not need to restart the cron service**. The daemon automatically detects the file change and updates the schedule.

### 2. Troubleshooting Missing Logs

I attempted to verify the job by checking /var/log/cron, but the file did not exist.

*   **Reason:** In minimal environments (or containers), rsyslog might not be installed, so text logs aren't written to disk.
    
*   **Solution:** I learned two alternative verification methods:
    
    1.  **Systemd Journal:** sudo systemctl status crond -l (Shows recent execution logs in memory).
        
    2.  **File Timestamp:** ls -l /tmp/cron\_text (Checking if the output file was created/updated).
        

### 3. Verification

The most reliable way to verify execution in this scenario was checking the output file:

```bash
ls -l /tmp/cron_text
```
## 🏷️ Tags
#100DaysOfDevOps #Linux #Automation #Cron #SysAdmin #KodeKloud