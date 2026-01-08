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