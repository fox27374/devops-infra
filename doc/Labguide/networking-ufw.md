# UFW
## Commands
| Command | Description |
| ---| --- |
| ufw | control the firewall |
---

## Tasks
### 1. Install the package ufw
**`sudo apt install ufw`**  

### 2. Enable the firewall
**`sudo ufw enable`**  

### 3. Check the ufw status
**`sudo ufw status`**  

### 4. Add the SSH service to the firewall rules
**`sudo ufw allow ssh`**  

### 5. Show the rules to confirm that SSH has been added 
**`sudo ufw status numbered`**  

### 6. Add a rule to allow TCP port 8080 
**`sudo ufw allow 8080/tcp`**  

### 7. Remove the random string in your nginx.conf and restart the nginx service
### 8. Open a browser and access your nginx webpage
### 9. If it dows not work, check the ufw logs located in /var/log/ufw.log (Hint: tail -f)
### 10. Check the port that nginx is listening on (Hint: netstat)
### 11. Reconfigure nginx to listen to port 8080 (Hint: ntslab config file)
### 12. Restart the nginx service and connect to your webpage
