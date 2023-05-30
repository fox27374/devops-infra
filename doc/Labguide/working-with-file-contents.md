# Working with file contents
## Commands
| Command | Description |
| ---| --- |
| head | display the top lines of a file |
| tail | display the bottom lines of a file |
| cat | concatenate files |
| more | display big files page by page |
| less | like more but interactive |
| echo | display passed arguments |
---

## Tasks
### 1. Display the first lines of a file
**`head -n 5 .bash_history`**

### 2. Display the last lines of a file
**`tail -15 /etc/services`**
```
dkofler@ibk-tr-deb01:~$ tail -15 /etc/services
sgi-gcd		17003/udp			# SGI Group membership daemon
sgi-cad		17004/tcp			# Cluster Admin daemon
isdnlog		20011/tcp			# isdn logging system
isdnlog		20011/udp
vboxd		20012/tcp			# voice box system
vboxd		20012/udp
binkp		24554/tcp			# binkp fidonet protocol
asp		27374/tcp			# Address Search Protocol
asp		27374/udp
csync2		30865/tcp			# cluster synchronization tool
dircproxy	57000/tcp			# Detachable IRC Proxy
tfido		60177/tcp			# fidonet EMSI over telnet
fido		60179/tcp			# fidonet EMSI over TCP

# Local services
```

### 3. Display the whole content of a file
**`cat /etc/network/interfaces`**
```
dkofler@ibk-tr-deb01:~$ cat /etc/network/interfaces
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug ens192
iface ens192 inet dhcp
```

### 4. Concatenate files
**`cat /etc/os-release /etc/resolv.conf`**

### 5. Write something to a file
**`echo "Something important" > important.txt`**  
**`cat important.txt`**
```
dkofler@ibk-tr-deb01:~$ echo "Something important" > important.txt
dkofler@ibk-tr-deb01:~$ cat important.txt 
Something important
```

### 6. Concatenate files into a new file
**`cat /etc/os-release /etc/resolv.conf important.txt > output.txt`**

### 7. Add content to a file
**`cat /proc/cpuinfo >> output.txt`**

### 8. Use cat to add content to a file
**`cat > content.txt`**  
Use CTRL+d to signal the end of file.
```
dkofler@ibk-tr-deb01:~$ cat > content.txt
This is some very cool content!
```

### 9. Use cat copy a file
**`cat content.txt > copy.txt`**

### 10. View a large file page by page
**`more /etc/mime.types`**

### 11. View a large file with less
**`less /etc/locale.gen`**
