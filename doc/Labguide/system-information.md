# System information
## Commands
| Command | Description |
| ---| --- |
| free | shows memory information |
| df | filesystem and disk usage |
| top | display linux processes |
| du | show file space usage |
---

## Tasks
### 1. Get CPU information
**`cat /proc/cpuinfo`**  
```
dkofler@ibk-tr-deb00:~$ cat /proc/cpuinfo 
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 45
model name	: Intel(R) Xeon(R) CPU E5-2620 0 @ 2.00GHz
stepping	: 7
microcode	: 0x718
cpu MHz		: 2000.000
cache size	: 15360 KB
physical id	: 0
siblings	: 1
core id		: 0
cpu cores	: 1
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
```

### 2. Get RAM information
**`free -h`** 
```
dkofler@ibk-tr-deb00:~$ free -h
              total        used        free      shared  buff/cache   available
Mem:          986Mi       179Mi       122Mi       6.0Mi       684Mi       645Mi
Swap:         974Mi       0.0Ki       974Mi
```

### 3. Get HDD information
**`df -h`** 
```
dkofler@ibk-tr-deb00:~$ df -h
Filesystem      Size  Used Avail Use% Mounted on
udev            479M     0  479M   0% /dev
tmpfs            99M  6.7M   92M   7% /run
/dev/sda1       6.9G  1.6G  5.0G  25% /
tmpfs           494M     0  494M   0% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs           494M     0  494M   0% /sys/fs/cgroup
tmpfs            99M     0   99M   0% /run/user/1000
```

### 4. Combined information using top
**`top`** 
```
dkofler@ibk-tr-deb00:~$ top

top - 17:35:05 up 1 day,  9:13,  1 user,  load average: 0.00, 0.00, 0.00
Tasks: 100 total,   1 running,  99 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.0 us,  0.3 sy,  0.0 ni, 99.7 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :    986.3 total,    121.5 free,    180.3 used,    684.5 buff/cache
MiB Swap:    975.0 total,    974.7 free,      0.3 used.    645.1 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND                                                                
28572 splunk    20   0  290348 117364  45896 S   0.7  11.6   1:05.95 splunkd                                                                
   10 root      20   0       0      0      0 I   0.3   0.0   0:37.59 rcu_sched                                                              
  299 root      20   0   48492  11252   9840 S   0.3   1.1   2:02.65 vmtoolsd                                                               
13625 root      20   0       0      0      0 I   0.3   0.0   0:22.51 kworker/0:1-events                                                     
    1 root      20   0  170588  10332   7748 S   0.0   1.0   0:12.48 systemd                                                                
    2 root      20   0       0      0      0 S   0.0   0.0   0:00.04 kthreadd                                                               
    3 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_gp                                                                 
    4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_par_gp                                                             
    6 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker/0:0H-kblockd                                                   
    8 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 mm_percpu_wq 
```

### 5. Find out what is using the disk space
**`sudo du -ch --max-depth=1 /var`** 
```
dkofler@ibk-tr-deb00:~$ sudo du -ch --max-depth=1 /var
4.0K	/var/mail
12K	    /var/tmp
67M	    /var/cache
4.0K	/var/local
17M	    /var/log
1.1M	/var/backups
4.0K	/var/opt
24K	    /var/www
137M	/var/lib
16K	    /var/spool
221M	/var
221M	total
```