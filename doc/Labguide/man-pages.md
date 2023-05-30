# Man pages
## Commands
| Command | Description |
| ---| --- |
| man | show manual page |
---
## Tasks
### 1. man command
**`man pwd`**

### 2. man configfile
**`man sysctl.conf`**

### 3. man daemon
**`man sshd`**

### 4. man containing a string
**`man -k ssh`**
```
dkofler@ibk-tr-deb01:~$ man -k ssh
authorized_keys (5)  - OpenSSH SSH daemon
git-shell (1)        - Restricted login shell for Git-only SSH access
rlogin (1)           - OpenSSH SSH client (remote login program)
rsh (1)              - OpenSSH SSH client (remote login program)
slogin (1)           - OpenSSH SSH client (remote login program)
ssh (1)              - OpenSSH SSH client (remote login program)
ssh-add (1)          - adds private key identities to the authentication agent
ssh-agent (1)        - authentication agent
ssh-argv0 (1)        - replaces the old ssh command-name as hostname handling
ssh-copy-id (1)      - use locally available keys to authorise logins on a remote machine
ssh-keygen (1)       - authentication key generation, management and conversion
ssh-keyscan (1)      - gather SSH public keys
ssh-keysign (8)      - ssh helper program for host-based authentication
ssh-pkcs11-helper (8) - ssh-agent helper program for PKCS#11 support
ssh_config (5)       - OpenSSH SSH client configuration files
sshd (8)             - OpenSSH SSH daemon
sshd_config (5)      - OpenSSH SSH daemon configuration file
```

### 5. Short description of the man page
**`whatis sshd`**
```
dkofler@ibk-tr-deb01:~$ whatis sshd
sshd (8)             - OpenSSH SSH daemon
dkofler@ibk-tr-deb01:~$ whatis ssh
ssh (1)              - OpenSSH SSH client (remote login program)
```

### 6. Sections of man pages
**`man man`**
```
1   Executable programs or shell commands
2   System calls (functions provided by the kernel)
3   Library calls (functions within program libraries)
4   Special files (usually found in /dev)
5   File formats and conventions eg /etc/passwd
6   Games
7   Miscellaneous (including macro packages and conventions)
8   System administration commands (usually only for root)
9   Kernel routines [Non standard]
```

**`man -k passwd`**
```
dkofler@ibk-tr-deb01:~$ man -k passwd
chgpasswd (8)        - update group passwords in batch mode
chpasswd (8)         - update passwords in batch mode
gpasswd (1)          - administer /etc/group and /etc/gshadow
grub-mkpasswd-pbkdf2 (1) - generate hashed password for GRUB
openssl-passwd (1ssl) - compute password hashes
pam_localuser (8)    - require users to be listed in /etc/passwd
passwd (1)           - change user password
passwd (1ssl)        - compute password hashes
passwd (5)           - the password file
update-passwd (8)    - safely update /etc/passwd, /etc/shadow and /etc/group
```

**`man 1 passwd`**
```
PASSWD(1)
NAME
    passwd - change user password

```

**`man 5 passwd`**
```
PASSWD(5)
NAME
    passwd - the password file
```