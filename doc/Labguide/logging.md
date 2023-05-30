# Logging
## Commands
| Command | Description |
| --- | --- |
| tail | display the tast lines of a file |
| journalctl | display journald information |
---

## Tasks
### 1. Open a 2nd SSH connection to your server
### 2. Open the nginx access.log with tail
**`sudo tail -f /var/log/nginx/access.log`**

### 3. Access the previously created webpage with your browser
**`http://ibk-trXX.ntslab.loc:<PORT>`**

### 4. Watch the access.log
### 5. Stop the tail command with [CTRL+c]
### 6. Open the nginx.conf file in /etc/nginx/
**`sudo vi /etc/nginx/nginx.conf`**

### 7. In the http section, add a random string and save the file
```
http {
	notworkingcommand
	##
	# Basic Settings
	##
```
### 8. Open the nginx error.log with tail
**`sudo tail -f /var/log/nginx/error.log`**

### 9. From the other CLI window, restart the nginx service
### 10. Watch the error.log
```
dkofler@ibk-tr-deb00:~$ sudo tail -f /var/log/nginx/error.log
2021/03/16 16:43:09 [emerg] 15806#15806: unknown directive "notworkingcommand" in /etc/nginx/nginx.conf:17
```

### 11. Search the journal for the error
**`sudo journalctl -u nginx`**
```
dkofler@ibk-tr-deb00:~$ sudo journalctl -u nginx
-- Logs begin at Mon 2021-03-15 08:22:17 CET, end at Tue 2021-03-16 16:46:38 CET. --
Mar 16 12:01:55 ibk-tr-deb00 systemd[1]: Started A high performance web server and a reverse proxy server.
Mar 16 16:43:09 ibk-tr-deb00 systemd[1]: Stopping A high performance web server and a reverse proxy server...
Mar 16 16:43:09 ibk-tr-deb00 systemd[1]: nginx.service: Succeeded.
Mar 16 16:43:09 ibk-tr-deb00 systemd[1]: Stopped A high performance web server and a reverse proxy server.
Mar 16 16:43:09 ibk-tr-deb00 systemd[1]: Starting A high performance web server and a reverse proxy server...
Mar 16 16:43:09 ibk-tr-deb00 nginx[15806]: nginx: [emerg] unknown directive "notworkingcommand" in /etc/nginx/nginx.conf:17
Mar 16 16:43:09 ibk-tr-deb00 nginx[15806]: nginx: configuration file /etc/nginx/nginx.conf test failed
Mar 16 16:43:09 ibk-tr-deb00 systemd[1]: nginx.service: Control process exited, code=exited, status=1/FAILURE
Mar 16 16:43:09 ibk-tr-deb00 systemd[1]: nginx.service: Failed with result 'exit-code'.
Mar 16 16:43:09 ibk-tr-deb00 systemd[1]: Failed to start A high performance web server and a reverse proxy server.
```

### 12. Remove the random string from the nginx.conf file and restart the service
### 13. Check the journal and the systemctl to make sure the service is running
### 14. Execute any sudo command (e.g sudo cat ....)
### 15. Check the last 15 lines of /var/log/auth.log