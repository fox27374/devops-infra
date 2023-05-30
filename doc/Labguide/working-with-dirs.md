# Working with directories
## Commands
| Command | Description |
| ---| --- |
| cd | change directory |
| ls | list directory |
| pwd | print working directory |
| mkdir | make directory |
| rmdir | remove directory |
---

## Tasks
### 1. List files in home folder
**`ls`**
```
dkofler@ibk-tr-deb01:~$ ls
dkofler@ibk-tr-deb01:~$
```

### 2. Extend the list output
**`ls -lah`**
```
dkofler@ibk-tr-deb01:~$ ls -lah
total 24K
drwxr-xr-x 2 dkofler dkofler 4.0K Mar  3 12:09 .
drwxr-xr-x 3 root    root    4.0K Mar  1 17:17 ..
-rw------- 1 dkofler dkofler  745 Mar  3 11:41 .bash_history
-rw-r--r-- 1 dkofler dkofler  220 Mar  1 17:17 .bash_logout
-rw-r--r-- 1 dkofler dkofler 3.5K Mar  1 17:17 .bashrc
-rw-r--r-- 1 dkofler dkofler  807 Mar  1 17:17 .profile
```

### 3. Show root filesystem
**`ls -l /`**
```
dkofler@ibk-tr-deb01:~$ ls -l /
total 60
lrwxrwxrwx   1 root root     7 Mar  1 17:11 bin -> usr/bin
drwxr-xr-x   3 root root  4096 Mar  1 17:17 boot
drwxr-xr-x  16 root root  3160 Mar  1 17:18 dev
drwxr-xr-x  71 root root  4096 Mar  3 10:32 etc
drwxr-xr-x   3 root root  4096 Mar  1 17:17 home
lrwxrwxrwx   1 root root    31 Mar  1 17:13 initrd.img -> boot/initrd.img-4.19.0-14-amd64
lrwxrwxrwx   1 root root    31 Mar  1 17:13 initrd.img.old -> boot/initrd.img-4.19.0-14-amd64
lrwxrwxrwx   1 root root     7 Mar  1 17:11 lib -> usr/lib
lrwxrwxrwx   1 root root     9 Mar  1 17:11 lib32 -> usr/lib32
lrwxrwxrwx   1 root root     9 Mar  1 17:11 lib64 -> usr/lib64
lrwxrwxrwx   1 root root    10 Mar  1 17:11 libx32 -> usr/libx32
drwx------   2 root root 16384 Mar  1 17:11 lost+found
drwxr-xr-x   3 root root  4096 Mar  1 17:11 media
drwxr-xr-x   2 root root  4096 Mar  1 17:11 mnt
drwxr-xr-x   2 root root  4096 Mar  1 17:11 opt
dr-xr-xr-x 154 root root     0 Mar  1 17:18 proc
drwx------   2 root root  4096 Mar  3 10:32 root
drwxr-xr-x  16 root root   500 Mar  3 12:08 run
lrwxrwxrwx   1 root root     8 Mar  1 17:11 sbin -> usr/sbin
drwxr-xr-x   2 root root  4096 Mar  1 17:11 srv
dr-xr-xr-x  13 root root     0 Mar  3 10:45 sys
drwxrwxrwt   8 root root  4096 Mar  3 12:19 tmp
drwxr-xr-x  13 root root  4096 Mar  1 17:11 usr
drwxr-xr-x  11 root root  4096 Mar  1 17:11 var
lrwxrwxrwx   1 root root    28 Mar  1 17:13 vmlinuz -> boot/vmlinuz-4.19.0-14-amd64
lrwxrwxrwx   1 root root    28 Mar  1 17:13 vmlinuz.old -> boot/vmlinuz-4.19.0-14-amd64
```

### 4. Use options in a different order
**`cd /usr`**  
**`ls -hl`**
```
dkofler@ibk-tr-deb01:/usr$ ls -hl
total 68K
drwxr-xr-x  2 root root  20K Mar  3 12:19 bin
drwxr-xr-x  2 root root 4.0K Jan 30 18:37 games
drwxr-xr-x  3 root root 4.0K Mar  1 17:23 include
drwxr-xr-x 53 root root 4.0K Mar  1 17:23 lib
drwxr-xr-x  2 root root 4.0K Mar  1 17:11 lib32
drwxr-xr-x  2 root root 4.0K Mar  1 17:12 lib64
drwxr-xr-x  2 root root 4.0K Mar  1 17:11 libx32
drwxr-xr-x 10 root root 4.0K Mar  1 17:11 local
drwxr-xr-x  2 root root  12K Mar  1 17:23 sbin
drwxr-xr-x 85 root root 4.0K Mar  1 17:23 share
drwxr-xr-x  2 root root 4.0K Jan 30 18:37 src
```

### 5. Change to the /var directory
**`cd /var`**

### 6. List files in the /var directory
**`ls -l`**
```
dkofler@ibk-tr-deb01:/var$ ls -l
total 36
drwxr-xr-x  2 root root  4096 Mar  3 06:25 backups
drwxr-xr-x  9 root root  4096 Mar  1 17:18 cache
drwxr-xr-x 25 root root  4096 Mar  1 17:23 lib
drwxrwsr-x  2 root staff 4096 Jan 30 18:37 local
lrwxrwxrwx  1 root root     9 Mar  1 17:11 lock -> /run/lock
drwxr-xr-x  5 root root  4096 Mar  3 00:00 log
drwxrwsr-x  2 root mail  4096 Mar  1 17:11 mail
drwxr-xr-x  2 root root  4096 Mar  1 17:11 opt
lrwxrwxrwx  1 root root     4 Mar  1 17:11 run -> /run
drwxr-xr-x  4 root root  4096 Mar  1 17:12 spool
drwxrwxrwt  3 root root  4096 Mar  3 00:00 tmp
```

### 7. Change to your home directory
**`cd`**

### 8. Print the working directory
**`pwd`**
```
dkofler@ibk-tr-deb01:~$ pwd
/home/dkofler
```

### 9. Change to the parent directory
**`cd ..`**
```
dkofler@ibk-tr-deb01:~$ cd ..
dkofler@ibk-tr-deb01:/home$ pwd
/home
```

### 10. Change to the /var/cache/apt directory
**`cd /var/cache/apt`**

### 11. Change back to the /home directory
**`cd -`**
```
dkofler@ibk-tr-deb01:/var/cache/apt$ cd -
/home
dkofler@ibk-tr-deb01:/home$
```

### 12. Use absolute and relaive paths
**`cd /boot`**
**`ls`**
```
dkofler@ibk-tr-deb01:~$ cd /boot
dkofler@ibk-tr-deb01:/boot$ ls
config-4.19.0-14-amd64  grub  initrd.img-4.19.0-14-amd64  System.map-4.19.0-14-amd64  vmlinuz-4.19.0-14-amd64
```
**`cd /grub`**
```
dkofler@ibk-tr-deb01:/boot$ cd /grub
-bash: cd: /grub: No such file or directory
```
**`cd grub`**
```
dkofler@ibk-tr-deb01:/boot$ cd grub
dkofler@ibk-tr-deb01:/boot/grub$ pwd
/boot/grub
```
### 13. Use tab completion
**`cd /var/ca<TAB>`**

### 14. Use same command with upper case letter
**`cd /var/Ca<TAB>`**

### 15. Create a directory
**`cd`**  
**`mkdir nts`**  
**`ls -l`**
```
dkofler@ibk-tr-deb01:~$ cd
dkofler@ibk-tr-deb01:~$ mkdir nts
dkofler@ibk-tr-deb01:~$ ls -l
total 4
drwxr-xr-x 2 dkofler dkofler 4096 Mar  6 18:39 nts
```

### 16. Create a subdirectory
**`mkdir nts/subdir`**    
**`ls -l nts`**

### 17. Create a new directory with a subdirectory
**`mkdir nts2/subdir2`**  
```
dkofler@ibk-tr-deb01:~$ mkdir nts2/subdir2
mkdir: cannot create directory ‘nts2/subdir2’: No such file or directory
```
### 18. Create a new directory with a subdirectory and the -p option
**`mkdir -p nts2/subdir2`**  
**`ls -l nts2`**
```
dkofler@ibk-tr-deb01:~$ ls -l nts2/
total 4
drwxr-xr-x 2 dkofler dkofler 4096 Mar  6 18:47 subdir2
```

### 19. Delete the subdir directory
**`rmdir nts/subdir`**

### 20. Delete the nts2 directory
**`rmdir nts2`**
```
dkofler@ibk-tr-deb01:~$ rmdir nts2
rmdir: failed to remove 'nts2': Directory not empty
```

### 21. Delete the subdir2 directory with the -p option
**`rmdir -p nts2/subdir2`**
