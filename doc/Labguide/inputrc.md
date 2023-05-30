# Inputrc
## Commands
| Command | Description |
| ---| --- |
| vi | the awesome editor |
---

## Tasks
### 1. Open the file /etc/inputrc with vi
**`sudo vi /etc/inputrc`**  

### 2. Add the following config to the file
Right after the section that starts with "alternate mappings for page up ..."
```
# Arrow up
"\e[A":history-search-backward
# Arrow down
"\e[B":history-search-forward
```
### 3. Save the file and logout of the system
### 4. Login again and type 'sudo ' then press the up-arrow key
