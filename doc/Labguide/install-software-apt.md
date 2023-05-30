# Install software
## Commands
| Command | Description |
| --- | --- |
| apt | debian package manager |
---

## Tasks
### 1. Update the apt repository
**`sudo apt update`**  

### 2. Install the tcpdump package
**`sudo apt install tcpdump`**  

### 3. Search the ufw package
**`sudo apt search ufw`**  

### 4. Install the packages ufw, dnsutils and nmap
**`sudo apt install ufw dnsutils nmap`**  

### 5. Remove the ufw package and purge all configs
**`sudo apt remove ufw --purge`**  

### 6. List all installed packages
**`sudo apt list --installed | more`**  

### 7. Check the used sources
**`cat /etc/apt/sources.list`** 