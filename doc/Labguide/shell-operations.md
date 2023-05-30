# Shell operations
## Commands
| Command | Description |
| ---| --- |
| echo | display passed arguments |
| type | test if internal or external command |
| which | search for binaries in the path variable |
| alias | create an alias for a command |
| ; | execute commands sequentially |
| & | send command to background |
| && | logical AND |
| \|\| | logical OR |
| # | shell comment |
| \\ | escaping, end of line |
---

## Tasks
### 1. Pass a couple of arguments to echo
**`echo hi this is a test`**
```
dkofler@ibk-tr-deb01:~$ echo hi this is a test
hi this is a test
```

### 2. Add some whitespaces
**`echo hi`** &nbsp;&nbsp;&nbsp;&nbsp; **`this is`** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **`a test`**
```
dkofler@ibk-tr-deb01:~$ echo hi      this is        a test
hi this is a test
```

### 3. Prevent whitespace removal
**`echo 'hi`** &nbsp;&nbsp;&nbsp;&nbsp; **`this is`** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **`a test'`**
```
dkofler@ibk-tr-deb01:~$ echo 'hi      this is        a test'
hi      this is        a test
```

### 4. Add a newline
**`echo -e "hi this is a test \n to test the newline"`**
```
dkofler@ibk-tr-deb01:~$ echo -e "hi this is a test \n to test the newline"
hi this is a test 
 to test the newline
```

### 5. Check it the command is internal or external
**`type cd cat ls`**
```
dkofler@ibk-tr-deb01:~$ type cd cat ls
cd is a shell builtin
cat is /usr/bin/cat
ls is aliased to `ls --color=auto'
```

### 6. Check the path variable for commands
**`which cd cat ls`**
```
dkofler@ibk-tr-deb01:~$ which cd cat ls
/usr/bin/cat
/usr/bin/ls
```

### 7. Create an alias for the ls -lh command
**`alias ll='ls -lh'`**  
**`ll'`**
```
dkofler@ibk-tr-deb01:~$ ll
total 40K
-rw-r--r-- 1 dkofler dkofler 1.3K Mar 11 13:53 cert.txt
-rw-r--r-- 1 dkofler dkofler   32 Mar 11 16:58 content.txt
-rw-r--r-- 1 dkofler dkofler   32 Mar 11 17:00 copy.txt
-rw-r--r-- 1 dkofler dkofler   13 Mar 11 16:44 daniel.txt
drwxr-xr-x 2 dkofler dkofler 4.0K Mar  7 21:12 dir3
drwxr-xr-x 2 dkofler dkofler 4.0K Mar  7 21:16 dir-renamed
```

### 8. Combine commands in one line
**`echo Hello > file1.txt; echo Hello2 >> file1.txt; cat file1.txt; rm file1.txt`**
```
dkofler@ibk-tr-deb01:~$ echo Hello > file1.txt; echo Hello2 >> file1.txt; cat file1.txt; rm file1.txt
Hello
Hello2
```

### 9. Start a command and send it to the background
**`ping -c 4 -i 7 blog.dot11.org &`**

### 10. Combine commands with a logical AND
**`sleep 5 && ping -c 3 www.google.at`**

### 11. Produce an error so that the 2nd command is not executed
**`sleep F && ping -c 3 www.google.at`**

### 12. Combine commands with a logical OR
**`cat daniel.txt || ls -l`**
```
dkofler@ibk-tr-deb01:~$ cat daniel.txt || ls -l
cat: daniel.txt: No such file or directory
total 40
-rw-r--r-- 1 dkofler dkofler 1289 Mar 11 13:53 cert.txt
-rw-r--r-- 1 dkofler dkofler   32 Mar 11 16:58 content.txt
-rw-r--r-- 1 dkofler dkofler   32 Mar 11 17:00 copy.txt
drwxr-xr-x 2 dkofler dkofler 4096 Mar  7 21:12 dir3
```

### 13. Combine the two logical operators
**`touch file1`**  
**`rm file1 && echo It worked! || echo It failed!`**  
```
dkofler@ibk-tr-deb01:~$ touch file1
dkofler@ibk-tr-deb01:~$ rm file1 && echo It worked! || echo It failed!
It worked!
```
**`rm file1 && echo It worked! || echo It failed!`**
```
dkofler@ibk-tr-deb01:~$ rm file1 && echo It worked! || echo It failed!
rm: cannot remove 'file1': No such file or directory
It failed!
```

### 14. Escape the special characters we used before
**`echo Lets print an ampersand \&\; Then print some other chars like \|, \' and \<.`**
```
dkofler@ibk-tr-deb01:~$ echo Lets print an ampersand \&\; Then print some other chars like \|, \' and \<.
Lets print an ampersand &; Then print some other chars like |, ' and <.
```

### 15. Multilines
**`echo This is a very long command \`**  
**`thats why we split it into \`**  
**`three lines`**
```
dkofler@ibk-tr-deb01:~$ echo This is a very long command \
> thats why we split it into \
> three lines
This is a very long command thats why we split it into three lines
```