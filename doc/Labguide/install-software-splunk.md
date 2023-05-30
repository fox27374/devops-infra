# Install custom software
## Commands
Use the following commands to navigate through the filesystem:

| Command | Description |
| --- | --- |
| wget | transfer files from url |
| tar | compress / extract files |
| netstat | show open ports and network connections |
---

## Tasks
### 1. Download the Splunk UF
This copies a tar file containing software to the directory you are currently in  
**`wget -O splunkforwarder-8.2.2.1-ae6821b7c64b-Linux-x86_64.tgz 'https://download.splunk.com/products/universalforwarder/releases/8.2.2.1/linux/splunkforwarder-8.2.2.1-ae6821b7c64b-Linux-x86_64.tgz'`**  

### 2. Move the file to the /opt directory
**`sudo mv splunkforwarder-8.2.2.1-ae6821b7c64b-Linux-x86_64.tgz /opt/`**  

### 3. Change to the /opt directory

### 4. Extract the package
**`sudo tar -xf splunkforwarder-8.2.2.1-ae6821b7c64b-Linux-x86_64.tgz`**  

### 5. Add a user with the following settings
* name: splunk
* uid: 10777
* home directory: /opt/splunkforwarder
* shell: /bin/bash  
Check man page to see how to set the home dir and the UID. [Hint](hint-add-user.md#5-add-a-user-with-the-following-settings)

### 6. Add the splunk user to the group adm
### 7. Set the password for the splunk user to 'splunk'
### 8. su to the splunk user and check if you are in the correct directory
### 9. Change to the /opt/splunkforwarder/bin directory
### 10. Execute the command to start splunk
**`./splunk start --accept-license`**  
When asked, provide the following credentials  
* administrator username: admin
* administrator password: admin#splunk

### 11. Check if splunk is running
**`./splunk status`**  

### 12. Stop splunk
**`./splunk stop`**

### 13. Exit the splunk user environment
### 14. As a normal user, change to the /opt/splunkforwarder/bin/ directory

### 15. Execute the following command to start splunk as a systemd process
**`sudo ./splunk enable boot-start -user splunk -systemd-managed 1`**

### 16. Open TCP port 8089/tcp in the UFW

### 17. Comment the following lines in the /etc/systemd/system/SplunkForwarder.service file (add a '#' in front)
**`ExecStartPost=/bin/bash -c "chown -R splunk:splunk /sys/fs/cgroup/cpu/system.slice/%n"`**
**`ExecStartPost=/bin/bash -c "chown -R splunk:splunk /sys/fs/cgroup/memory/system.slice/%n"`**

### 18. Reload systemd systemd to read the changed config file
**`sudo systemctl daemon-reload`**

### 19. Start splunk using systemd
**`sudo systemctl start SplunkForwarder.service`**

### 20. Check the status of the splunk service
**`sudo systemctl status SplunkForwarder.service`**

### 21. su to the splunk user
### 22. Change to the /opt/splunkforwarder/bin directory
### 23. Execute the command to connect splunk to the depoyment server
**`./splunk set deploy-poll spl-master.ntslab.loc:8089`**  
When asked, provide the admin credentials  
* administrator username: admin
* administrator password: admin#splunk  

### 24. Exit the splunk user environment
### 25. Restart splunk using systemd
**`sudo systemctl restart SplunkForwarder.service`**

### 26. Enable automatic startup of splunk using systemd
**`sudo systemctl enable SplunkForwarder.service`**

### 27. Check the port splunk is using for communication