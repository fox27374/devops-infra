# Shell variables
## Commands
| Command | Description |
| ---| --- |
| echo | display passed arguments |
| set | display variables |
| unset | delets a variable |
| export | exports a variable to env |
---

## Tasks
### 1. Print your current shell
**`echo $SHELL`**
```
dkofler@ibk-tr-deb01:~$ echo $SHELL
/bin/bash
```

### 2. Combine variables
**`echo This is $USER on $HOSTNAME and I am using $SHELL. My ID is $UID and currently in $PWD`**
```
dkofler@ibk-tr-deb01:~$ echo This is $USER on $HOSTNAME and I am using $SHELL. My ID is $UID and currently in $PWD
This is dkofler on ibk-tr-deb01 and I am using /bin/bash. My ID is 1000 and currently in /home/dkofler
```

### 3. Variables are case sensitive
**`echo Hostname: $HOSTNAME`**  
**`echo Hostname: $hostname`**
```
dkofler@ibk-tr-deb01:~$ echo Hostname: $HOSTNAME
Hostname: ibk-tr-deb01
dkofler@ibk-tr-deb01:~$ echo Hostname $hostname
Hostname
```

### 4. Create your own variable
**`myvar=Slayer`**  
**`echo $myvar`**

### 5. Test the difference between single and double quotes
**`echo $myvar`**  
**`echo "$myvar"`**  
**`echo '$myvar'`**
```
dkofler@ibk-tr-deb01:~$ echo $myvar
Slayer
dkofler@ibk-tr-deb01:~$ echo "$myvar"
Slayer
dkofler@ibk-tr-deb01:~$ echo '$myvar'
$myvar
```

### 6. Display available variables
**`set | more`**

### 7. Delete variables
**`unset myvar`**  
**`echo $myvar`**

### 8. Have a look at the $PS1 variable
**`echo $PS1`**
```
dkofler@ibk-tr-deb01:~$ echo $PS1
\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$
```

### 9. Have a look at the $PATH variable
**`echo $PATH`**
```
dkofler@ibk-tr-deb01:~$ echo $PATH
/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
```

### 10. Display the exported variables in env
**`env`**

### 11. Test the difference between local and exported variables
**`myvar2=two`**  
**`myvar3=three`**  
**`export myvar2`**  
**`echo $myvar2 $myvar3`**
```
dkofler@ibk-tr-deb01:~$ echo $myvar2 $myvar3
two three
```
**`bash`**  
**`echo $myvar2 $myvar3`**
```
dkofler@ibk-tr-deb01:~$ echo $myvar2 $myvar3
two
```

### 12. Embedd commands
**`echo The kernel version is $(uname -r)`**
```
dkofler@ibk-tr-deb01:~$ echo The kernel version is $(uname -r)
The kernel version is 4.19.0-14-amd64
```

**`echo The OS version is $(cat /etc/debian_version)`**
```
dkofler@ibk-tr-deb01:~$ echo The OS version is $(cat /etc/debian_version)
The OS version is 10.8
```