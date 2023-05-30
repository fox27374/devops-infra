# Shell history
## Commands
| Command | Description |
| ---| --- |
| history | display the shell history |
| ! | execute history commands |
---

## Tasks
### 1. Repeat the last command
**`cat /etc/os-release | grep PRETTY`**  
**`!!`**
```
dkofler@ibk-tr-deb01:~$ !!
cat /etc/os-release | grep PRETTY
PRETTY_NAME="Debian GNU/Linux 10 (buster)"
```

### 2. Repeat the last command starting with "to"
**`!to`**  
```
dkofler@ibk-tr-deb01:~$ !to
touch file1
```

### 3. Show the last 10 history entries
**`history 10`**  
```
dkofler@ibk-tr-deb01:~$ history 10
  541  echo $myvar2
  542  env -i echo $myvar2
  543  env -i bash -c echo $myvar2
  544  env | grep myvar
  545  cat /etc/os-release | grep DEBIAN
  546  cat /etc/os-release
  547  cat /etc/os-release | grep NAME
  548  cat /etc/os-release | grep PRETTY
  549  touch file1
  550  history 10
```

### 4. Execute the command number n
**`!545`**  
```
dkofler@ibk-tr-deb01:~$ !545
cat /etc/os-release | grep DEBIAN
```

### 5. Search the history for the last command containing a word
**`CTRL+r`**  
**`ip`**
```
(reverse-i-search)`ip': ip address show dev ens192 | grep -w 'inet' | awk '{print $2}' # Get IP of ens192
dkofler@ibk-tr-deb01:~$ ip address show dev ens192 | grep -w 'inet' | awk '{print $2}' # Get IP of ens192
172.24.88.112/24
```

### 6. Prevent a command from being recorded in the history (space before the command)
**`echo Password is abcdef`**  
&nbsp;**` echo Password is ghijkl`**  
**`history 3`**
```
dkofler@ibk-tr-deb01:~$ history 3
  555  ip address show dev ens192 | grep -w 'inet' | awk '{print $2}' # Get IP of ens192
  556  echo Password is abcdef
  557  history 3
```
