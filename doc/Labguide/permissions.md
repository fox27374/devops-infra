# Permissions
## Commands
| Command | Description |
| ---| --- |
| chown | change file / directory owner |
| chmod | modify file / directory permissions |
---

## Tasks
### 1. Create a directory and a file that you own
**`mkdir permissions; touch permissions/file1`**  

### 2. Copy a file owned by root with sudo to the new directory
**`cd permissions/ && sudo cp /etc/resolv.conf .`**  
**`ll`**  
```
dkofler@ibk-tr-deb00:~/permissions$ ll
total 4
-rw-r--r-- 1 dkofler dkofler  0 Mar 15 16:22 file1
-rw-r--r-- 1 root    root    84 Mar 15 16:25 resolv.conf
```
### 3. Copy the same file without sudo
**`cp /etc/resolv.conf resolv2.conf`**  
**`ll`**
```
dkofler@ibk-tr-deb00:~/permissions$ ll
total 8
-rw-r--r-- 1 dkofler dkofler  0 Mar 15 16:22 file1
-rw-r--r-- 1 dkofler dkofler 84 Mar 15 16:26 resolv2.conf
-rw-r--r-- 1 root    root    84 Mar 15 16:25 resolv.conf
```
### 4. Remove the group and other permissions and try to print it
**`sudo chmod 600 resolv.conf`**  
**`ll`**  
**`cat resolv.conf`**
```
dkofler@ibk-tr-deb00:~/permissions$ sudo chmod 600 resolv.conf
dkofler@ibk-tr-deb00:~/permissions$ ll
total 8
-rw-r--r-- 1 dkofler dkofler  0 Mar 15 16:22 file1
-rw-r--r-- 1 dkofler dkofler 84 Mar 15 16:26 resolv2.conf
-rw------- 1 root    root    84 Mar 15 16:46 resolv.conf
dkofler@ibk-tr-deb00:~/permissions$ cat resolv.conf 
cat: resolv.conf: Permission denied
```

### 5. Change the group owner to group1 and ass rw permissions
**`sudo chown root:group1 resolv.conf`**  
**`sudo chmod g+rw resolv.conf`**  
**`ll`**

### 6. su to user3 and edit the file
**`su - user3`**  
**`vi /home/<YOUR USER>/permissions/resolv.conf`**  
**`exit`**

### 7. Add your user to group1 and print the file
**`sudo usermod -aG <YOUR USER> group1`**  
**`cat resolv.conf`**  

### 8. Remove the x permission of the permissions folder
**`cd ~`**  
**`chmod -x permissions`**  
**`cd permissions`**  
```
dkofler@ibk-tr-deb00:~$ cd permissions/
-bash: cd: permissions/: Permission denied
```

### 9. Set 755 for the permissions directory and all file in it
**`chmod -R 755 permissions`**  
**`ll permissions/`**  
```
dkofler@ibk-tr-deb00:~$ chmod -R 755 permissions
chmod: changing permissions of 'permissions/resolv.conf': Operation not permitted
dkofler@ibk-tr-deb00:~$ ll permissions/
total 8
-rwxr-xr-x 1 dkofler dkofler  0 Mar 15 16:22 file1
-rwxr-xr-x 1 dkofler dkofler 84 Mar 15 16:26 resolv2.conf
-rw-rw---- 1 root    group1  89 Mar 15 17:01 resolv.conf
```