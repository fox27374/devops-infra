# Using vi
## Commands
| Command | Description |
| ---| --- |
| ESC | change to command mode |
| i | start typing before the current character |
| u | undo last action |
| dd | cut the current line |
| yy | copy the current line |
| p | paste after the current line |
| /string | search string in file (n next, N previous) |
| :num | jump to line number |
| :w | write file |
| :q | quit |
---

## Tasks
### 1. Uncomment an alias in .bashrc
Open the file with vi  
**`vi .bashrc`**  
Search for a commented alias line  
**`/#alias [ENTER]`**  
Go down until you find the line "#alias ll='ls -l'"  
**`n`**  
Change to insert mode  
**`i`**  
Remove the "#" to uncomment the line  
Change to command mode  
**`[ESC]`**  
Write the file and quit vi  
**`:wq [ENTER]`**  
Reload the file so that you can use the alias  
**`source .bashrc`**  
```
dkofler@ibk-tr-deb01:~$ ll
-bash: ll: command not found
dkofler@ibk-tr-deb01:~$ source .bashrc 
dkofler@ibk-tr-deb01:~$ ll
total 44
-rw-r--r-- 1 dkofler dkofler 1289 Mar 11 13:53 cert.txt
-rw-r--r-- 1 dkofler dkofler   32 Mar 11 16:58 content.txt
-rw-r--r-- 1 dkofler dkofler   32 Mar 11 17:00 copy.txt
drwxr-xr-x 2 dkofler dkofler 4096 Mar  7 21:12 dir3
drwxr-xr-x 2 dkofler dkofler 4096 Mar  7 21:16 dir-renamed
-rw-r--r-- 1 dkofler dkofler   54 Mar 14 17:28 error.txt
```

### 2. Remove a line from .bash_history
Open the file with vi  
**`vi .bash_history`**  
Go to line 32  
**`:32 [ENTER]`**  
Delete the whole line  
**`dd`**  
Write the file and quit vi  
**`:wq [ENTER]`**  


### 3. Edit a copy of resolv.conf
Copy the file to your home directory   
**`cp /etc/resolv.conf .`**  
Open the file with vi  
**`vi resolv.conf`**  
Move the cursor to the last nameserver entry  
Copy the line  
**`yy`**  
Move the cursor two lines up and paste the copied line  
**`p`**  
Change the last octet to 23    
**`i`**  
Change to command mode  
**`[ESC]`**  
Write the file and quit vi  
**`:wq [ENTER]`**
