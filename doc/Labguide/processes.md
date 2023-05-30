# Processes
## Commands
| Command | Description |
| ---| --- |
| systemctl| start / stop / status of processes |
| ps | list all running processes |
| kill | send a termination signal to a process |
| netstat | show open ports and network connections |
---

## Tasks
### 1. Show the systemctl status
**`sudo systemctl status`**  

### 2. Show the sshd status
**`sudo systemctl status sshd`**  

### 3. Show all enabled services
**`sudo systemctl list-unit-files | grep enabled`**  

### 4. Restart the sshd service
**`sudo systemctl restart sshd`**  

### 5. Disable the open-vm-tools.service service
**`sudo systemctl disable open-vm-tools.service`**

### 6. Enable the service
**`sudo systemctl enable open-vm-tools.service`**

### 7. Show all running processes
**`ps -ef`**

### 8. Remove the ones that have a '[' in the cmd
**`ps -ef | grep -v '\['`**
```
dkofler@ibk-tr-deb12:~$ ps -ef | grep -v '\['
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 Mar15 ?        00:00:04 /sbin/init
root       245     1  0 Mar15 ?        00:00:00 /lib/systemd/systemd-journald
root       266     1  0 Mar15 ?        00:00:00 /lib/systemd/systemd-udevd
systemd+   429     1  0 Mar15 ?        00:00:00 /lib/systemd/systemd-timesyncd
root       431     1  0 Mar15 ?        00:00:00 /usr/sbin/rsyslogd -n -iNONE
```

### 9. Create a new process and send it to the background
**`ping 8.8.8.8 > /dev/null &`**

### 10. Find the ping process in the process list
**`ps -ef | grep ping`**

### 11. Kill the process and use the ps command again
**`kill -9 <PID>`**  
**`ps -ef | grep ping`**
```
dkofler@ibk-tr-deb12:~$ ps -ef | grep ping
dkofler   6427  6026  0 15:13 pts/0    00:00:00 grep ping
[1]+  Killed                  ping 8.8.8.8 > /dev/null
```

### 12. Install the net-tools package using apt
**`sudo apt install net-tools`**

### 13. List all tcp/udp ports in listening state
**`netstat -tulpn`**
```
dkofler@ibk-tr-deb12:~$ netstat -tulpn 
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      -                   
tcp6       0      0 :::22                   :::*                    LISTEN      -                 
```