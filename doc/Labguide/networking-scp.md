# SCP
## Commands
| Command | Description |
| ---| --- |
| dd | convert and copy a file |
| scp | copy remote files |
---

## Tasks
### 1. Create a file called file-trXX (XX = your student number) and fill it with random data
**`dd if=/dev/urandom of=file-trXX bs=1M count=50`**  

### 2. Add your name to the end of the file
**`echo -e '\n\n<YOUR NAME>' >> file-trXX`**

### 3. Check if the name was added correctly
### 4. Check the filesize of the new file
### 5. Copy the file to the home folder of the remote system
Username: remoteuser  
Password: remoteuser  
**`scp file-trXX remoteuser@ibk-lnx-tr00.ntslab.loc:~`** 

### 6. Copy the file of one of your lab colleagues to your home directory
Username: remoteuser  
Password: remoteuser
YY is the student number of one of your lab colleagues  
**`scp remoteuser@ibk-tr-deb00.ntslab.loc:file-trYY .`** 

### 7. Check the filesize of the copied file
### 8. Check the name of your colleague in the file
