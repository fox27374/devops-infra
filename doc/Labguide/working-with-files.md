# Working with files
## Commands
| Command | Description |
| ---| --- |
| file | determine the filetype |
| touch | create an empty file |
| cp | copy |
| mv | move |
| rm | remove |
---

## Tasks
### 1. Check filetypes of different files
**`file /usr/bin/ls`**
```
dkofler@ibk-tr-deb01:~$ file /usr/bin/ls
/usr/bin/ls: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 3.2.0, BuildID[sha1]=a65f86cd6394e8f583c14d786d13b3bcbe051b87, stripped
```
**`file /etc/hostname`**
```
dkofler@ibk-tr-deb01:~$ file /etc/hostname 
/etc/hostname: ASCII text
```

**`file /usr/share/pixmaps/debian-logo.png`**
```
dkofler@ibk-tr-deb01:~$ file /usr/share/pixmaps/debian-logo.png
/usr/share/pixmaps/debian-logo.png: PNG image data, 48 x 48, 8-bit/color RGBA, non-interlaced
```

**`file /dev/sda1`**
```
dkofler@ibk-tr-deb01:~$ file /dev/sda1
/dev/sda1: block special (8/1
```

### 2. Create files with touch
**`touch file1`**  
**`touch file2`**  
**`ls -l`**
```
dkofler@ibk-tr-deb01:~$ touch file1
dkofler@ibk-tr-deb01:~$ touch file2
dkofler@ibk-tr-deb01:~$ ls -l
total 0
-rw-r--r-- 1 dkofler dkofler 0 Mar  7 20:51 file1
-rw-r--r-- 1 dkofler dkofler 0 Mar  7 20:51 file2

```

### 3. Create a file with a certain timestamp
**`touch -t 198404021042 file3`**  
**`ls -l`**
```
dkofler@ibk-tr-deb01:~$ ls -l
total 0
-rw-r--r-- 1 dkofler dkofler 0 Mar  7 20:51 file1
-rw-r--r-- 1 dkofler dkofler 0 Mar  7 20:51 file2
-rw-r--r-- 1 dkofler dkofler 0 Apr  2  1984 file3
```

### 4. Delete a file
**`rm file1`**  
**`ls -l`**
```
dkofler@ibk-tr-deb01:~$ ls -l
total 0
-rw-r--r-- 1 dkofler dkofler 0 Mar  7 20:51 file2
-rw-r--r-- 1 dkofler dkofler 0 Apr  2  1984 file3
```

### 5. Delete non-empty directory
**`mkdir dir1`**  
**`touch dir1/file4`**  
**`rm -rf dir1`**
```
dkofler@ibk-tr-deb01:~$ mkdir dir1
dkofler@ibk-tr-deb01:~$ touch dir1/file4
dkofler@ibk-tr-deb01:~$ rmdir dir1
rmdir: failed to remove 'dir1': Directory not empty
dkofler@ibk-tr-deb01:~$ rm -rf dir1
dkofler@ibk-tr-deb01:~$ ls -l
total 0
-rw-r--r-- 1 dkofler dkofler 0 Mar  7 20:51 file1
-rw-r--r-- 1 dkofler dkofler 0 Mar  7 20:51 file2
-rw-r--r-- 1 dkofler dkofler 0 Apr  2  1984 file3
```

### 6. Copy a file
**`cp file1 file11`**  
**`ls -l`**
```
dkofler@ibk-tr-deb01:~$ cp file1 file11
dkofler@ibk-tr-deb01:~$ ls -l
total 0
-rw-r--r-- 1 dkofler dkofler 0 Mar  7 20:51 file1
-rw-r--r-- 1 dkofler dkofler 0 Mar  7 21:06 file11
-rw-r--r-- 1 dkofler dkofler 0 Mar  7 20:51 file2
-rw-r--r-- 1 dkofler dkofler 0 Apr  2  1984 file3
```

### 7. Copy a file to another directory
**`mkdir dir2`**  
**`cp file2 dir2/`**  
**`ls dir2`**
```
dkofler@ibk-tr-deb01:~$ mkdir dir2
dkofler@ibk-tr-deb01:~$ cp file2 dir2/
dkofler@ibk-tr-deb01:~$ ls dir2
file2
```

### 8. Copy a whole directory with files
**`cp -r dir2 dir3`**  
**`ls -l dir3`**
```
dkofler@ibk-tr-deb01:~$ cp -r dir2 dir3
dkofler@ibk-tr-deb01:~$ ls -l dir3
total 0
drwxr-xr-x 2 dkofler dkofler 4096 Oct 11 14:19 dir2
```

### 9. Copy multiple files to a directory
**`cp file1 file11 file3 dir3/`**  
**`ls -l dir3`**
```
dkofler@ibk-tr-deb01:~$ cp file1 file11 file3 dir3/
dkofler@ibk-tr-deb01:~$ ls -l dir3
total 0
-rw-r--r-- 1 dkofler dkofler 0 Mar  7 21:12 file1
-rw-r--r-- 1 dkofler dkofler 0 Mar  7 21:12 file11
-rw-r--r-- 1 dkofler dkofler 0 Mar  7 21:10 file2
-rw-r--r-- 1 dkofler dkofler 0 Mar  7 21:12 file3
```

### 10. Move files to a directory
**`mv file1 dir2/`**  
**`ls`**

```
dkofler@ibk-tr-deb01:~$ ls
dir2  dir3  file1  file11  file2  file3
dkofler@ibk-tr-deb01:~$ mv file1 dir2/
dkofler@ibk-tr-deb01:~$ ls
dir2  dir3  file11  file2  file3
```

### 11. Rename a file or a directory
**`mv file11 file-renamed`**  
**`mv dir2 dir-renamed`**  
**`ls -la`**
```
dkofler@ibk-tr-deb01:~$ mv file11 file-renamed
dkofler@ibk-tr-deb01:~$ ls
dir2  dir3  file2  file3  file-renamed
dkofler@ibk-tr-deb01:~$ mv dir2 dir-renamed
dkofler@ibk-tr-deb01:~$ ls -la
total 32
drwxr-xr-x 4 dkofler dkofler 4096 Mar  7 21:19 .
drwxr-xr-x 3 root    root    4096 Mar  1 17:17 ..
-rw------- 1 dkofler dkofler 1852 Mar  6 19:02 .bash_history
-rw-r--r-- 1 dkofler dkofler  220 Mar  1 17:17 .bash_logout
-rw-r--r-- 1 dkofler dkofler 3526 Mar  1 17:17 .bashrc
drwxr-xr-x 2 dkofler dkofler 4096 Mar  7 21:12 dir3
drwxr-xr-x 2 dkofler dkofler 4096 Mar  7 21:16 dir-renamed
-rw-r--r-- 1 dkofler dkofler    0 Mar  7 20:51 file2
-rw-r--r-- 1 dkofler dkofler    0 Apr  2  1984 file3
-rw-r--r-- 1 dkofler dkofler    0 Mar  7 21:06 file-renamed
-rw-r--r-- 1 dkofler dkofler  807 Mar  1 17:17 .profile
```
