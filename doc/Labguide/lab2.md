# Setup an on premises wordpress site
## Commands
Use the following commands to navigate through the filesystem:

| Command | Description |
| --- | --- |
| wget | transfer files from url |
| tar | compress / extract files |
| chown | change file / directory owner |
| chmod | modify file / directory permissions |
| netstat | show open ports and network connections |
| systemctl | controll processes |
| docker | container runtime |
---

## Tasks
## Server 1 ##
### 1. Start a Splunk server with docker
Refer to the [this](https://hub.docker.com/r/splunk/splunk/#documentation) documentation.  
Dont forget to forward the following ports:
* 80:8000
* 8089:8089
* 9997:9997

### 2. Check if the container is up and running
**`docker ps`**  

## Server 2 ##
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
**`./splunk set deploy-poll <SERVER 1 IP>:8089`**  
When asked, provide the admin credentials  
* administrator username: admin
* administrator password: admin#splunk  

### 24. Exit the splunk user environment
### 25. Restart splunk using systemd
**`sudo systemctl restart SplunkForwarder.service`**

### 26. Enable automatic startup of splunk using systemd
**`sudo systemctl enable SplunkForwarder.service`**

### 27. Check the port splunk is using for communication

### 28. su to the splunk user

### 29. Create a new directory and config file
**`mkdir -p etc/apps/app_linux_lab/local`**

### 30. Create a new file named outputs.conf in the newly created folder and paste the following content
```ini
[tcpout]
defaultGroup=lab_indexers

[tcpout:lab_indexers]
server=<SERVER 1 IP>:9997
```

### 31. Create a new file named inputs.conf in the newly created folder and paste the following content
```ini
[monitor:///var/log/auth.log]
```

## Server 1 ##
### 1. Login to you new Splunk server with the provided password

### 2. Go settings - server settings - general and set the free diskspace limit to 500

### 3. Go settings - server controls and restart splunk

### 4. After the restart, log in again and go to the Search & Reporting app

### 5. Execute the following search and check if the server 2 hostname shows up in the restults
**`index=main | stats count by host`**
