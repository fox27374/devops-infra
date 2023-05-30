# User management
## Commands
| Command | Description |
| ---| --- |
| useradd | add a Linux user |
| userdel | delete a Linux user |
| usermod | modify user settings |
| groupadd | add a Linux group |
| su | substitute user |
| whoami | print the current username |
| id | print user and group IDs |
---


## Tasks
### 1. Create a new user
**`sudo useradd user1`**  
**`ll /home/`**  
**`su user1`**  

### 2. Set a password for the user
**`sudo passwd user1`**  
**`ll /home/`**  
**`su user1`**  

### 3. Create a new user with a home directory and a comment
**`sudo useradd -m -c 'Testuser 2' user2`**  
**`ll /home/`**  
**`sudo passwd user2`**  
**`su user2`**  

### 4. Check the shell the user is using
**`cat /etc/passed | grep user2`**  
```
dkofler@ibk-tr-deb00:~$ cat /etc/passwd | grep user2
user2:x:1003:1003::/home/user2:/bin/sh
```

### 5. Create a new user with a home directory with bash as the default shell
**`sudo useradd -m -c 'Testuser 3' -s /bin/bash user3`**  
**`sudo passwd user3`**  
**`su user3`**  
```
dkofler@ibk-tr-deb00:~$ su - user3
Password: 
user3@ibk-tr-deb00:~$ whoami
user3
user3@ibk-tr-deb00:~$ pwd
/home/user3
```

### 6. Remove a user
**`sudo userdel -r user1`**  

### 7. Create a new group and add user3 to the group
**`sudo groupadd group1`**  
**`sudo usermod -aG group1 user3`**  
**`groups user3`**  
```
dkofler@ibk-tr-deb00:~$ groups user3
user3 : user3 group1
```

### 8. Modify /etc/skel and create a new user
**`sudo vi /etc/skel/.bashrc`**  
Uncomment the 'll' alias and save the file  
**`sudo useradd -m -c 'Testuser 4' -s /bin/bash user4`**  
**`sudo passwd user4`**  
Login to the user and try the 'll' command   
**`su - user4`**  
**`ll`**  
Print the users IDs  
**`id`**  
