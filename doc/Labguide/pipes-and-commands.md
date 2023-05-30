# Pipes and commands
## Commands
| Command | Description |
| ---| --- |
| tee | write STDOUT to file |
| grep | filter lines containing a string |
| cut | filter columns depending on the delimiter |
| tr | translate characters |
| wc | count words, lines or characters |
| sort | sort based on options |
| uniq | remove duplicates from a sorted list |
| sed | edit filestream based on regex |
---

## Tasks
### 1. Delete non existent file and redirect error
**`rm file10`**  
**`rm file10 2> error.txt`**
```
dkofler@ibk-tr-deb01:~$ rm file10
rm: cannot remove 'file10': No such file or directory
dkofler@ibk-tr-deb01:~$ rm file10 2> error.txt
dkofler@ibk-tr-deb01:~$ cat error.txt 
rm: cannot remove 'file10': No such file or directory
```

### 2. Redirect errors to /dev/null
**`mv /etc /test 2> /dev/null`**  

```
dkofler@ibk-tr-deb01:~$ mv /etc /test
mv: cannot move '/etc' to '/test': Permission denied
dkofler@ibk-tr-deb01:~$ mv /etc /test 2> /dev/null
```

### 3. Compine STDOUT and STDERR to filter the result
**`rm file42 file33 file1201 | grep file42`**  
**`rm file42 file33 file1201 2>&1 | grep file42`**

```
dkofler@ibk-tr-deb01:~$ rm file42 file33 file1201 | grep file42
rm: cannot remove 'file42': No such file or directory
rm: cannot remove 'file33': No such file or directory
rm: cannot remove 'file1201': No such file or directory

dkofler@ibk-tr-deb01:~$ rm file42 file33 file1201 2>&1 | grep file42
rm: cannot remove 'file42': No such file or directory
```

### 4. Use tee to create a logfile
**`ping blog.dot11.org | tee ping.log`**  

```
dkofler@ibk-tr-deb01:~$ ping blog.dot11.org | tee ping.log
PING blog.dot11.org (116.203.37.199) 56(84) bytes of data.
64 bytes from static.199.37.203.116.clients.your-server.de (116.203.37.199): icmp_seq=1 ttl=51 time=26.0 ms
64 bytes from static.199.37.203.116.clients.your-server.de (116.203.37.199): icmp_seq=2 ttl=51 time=29.3 ms
^C

dkofler@ibk-tr-deb01:~$ cat ping.log 
PING blog.dot11.org (116.203.37.199) 56(84) bytes of data.
64 bytes from static.199.37.203.116.clients.your-server.de (116.203.37.199): icmp_seq=1 ttl=51 time=26.0 ms
64 bytes from static.199.37.203.116.clients.your-server.de (116.203.37.199): icmp_seq=2 ttl=51 time=29.3 ms
```

### 5. search all lines containing "curl" using grep
**`cat /var/log/dpkg.log | grep curl`**  

### 6. filter the result and exclude "status" using grep
**`cat /var/log/dpkg.log | grep curl | grep -v status`**  

### 7. Display one line before and after the search result
**`cat /var/log/dpkg.log | grep -C1 'configure curl'`**

### 8. Display the fields 1 and 3 of /etc/passwd using cut
**`cat /etc/passwd | cut -d : -f 1,3'`**

### 9. Display only field 1 /proc/cpuinfo
**`cat /proc/cpuinfo | cut -f 1`**

### 10. Translate all 'e' to 'E'
**`cat /etc/ssh/ssh_config  | tr e E`**

### 11. Translate everything to uppercase
**`cat /etc/ssh/sshd_config  | tr [a-z] [A-Z]`**

### 12. Translate all newlines into spaces
**`cat .bashrc  | tr '\n' ' '`**

### 13. Count all lines, words and characters in a file
**`cat .bashrc  | wc -l`**  
**`cat .bashrc  | wc -w`**  
**`cat .bashrc  | wc -c`**

### 14. Sort the output alphabetically
**`cat /etc/passwd | sort`**

### 15. Remove duplicates from a sorted list
**`cat /var/log/dpkg.log | cut -d ' ' -f 3 | sort | uniq`**

### 16. Change ip address in a config file using sed
**`cat /etc/resolv.conf | sed 's/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/127.0.0.1/g'`**
```
dkofler@ibk-tr-deb01:~$ cat /etc/resolv.conf
domain NTSLAB.loc
search NTSLAB.loc
nameserver 172.24.85.10
nameserver 172.24.85.10
dkofler@ibk-tr-deb01:~$ cat /etc/resolv.conf | sed 's/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/127.0.0.1/g'
domain NTSLAB.loc
search NTSLAB.loc
nameserver 127.0.0.1
nameserver 127.0.0.1
```

### 17. Find all .conf files in /etc
**`find /etc -maxdepth 1 -name '*.conf'`**
```
dkofler@ibk-tr-deb00:~$ find /etc -maxdepth 1 -name '*.conf'
/etc/discover-modprobe.conf
/etc/resolv.conf
/etc/debconf.conf
/etc/ld.so.conf
/etc/host.conf
/etc/reportbug.conf
/etc/kernel-img.conf
/etc/hdparm.conf
/etc/pam.conf
/etc/xattr.conf
/etc/rsyslog.conf
/etc/deluser.conf
/etc/libaudit.conf
/etc/ucf.conf
/etc/mke2fs.conf
/etc/logrotate.conf
/etc/ca-certificates.conf
/etc/gai.conf
/etc/sysctl.conf
/etc/adduser.conf
/etc/nsswitch.conf
/etc/fuse.conf
```
### 18. Find all .gz files in /var/log of the type file
**`find /var/log/ -type f -name '*.gz' 2> /dev/null`**
```
dkofler@ibk-tr-deb00:~$ find /var/log/ -type f -name '*.gz' 2> /dev/null
/var/log/syslog.6.gz
/var/log/syslog.7.gz
/var/log/syslog.3.gz
/var/log/syslog.2.gz
/var/log/kern.log.2.gz
/var/log/syslog.5.gz
/var/log/syslog.4.gz
/var/log/daemon.log.2.gz
/var/log/messages.2.gz
/var/log/auth.log.2.gz
```