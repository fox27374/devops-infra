# Networking
## Commands
| Command | Description |
| ---| --- |
| ping | classic ping command |
| dig | query DNS server |
| ip | modify IP addresses and get ip and routing info |
| tcpdump | low level packet dump |
---

## Tasks
### 1. Display the current ip configuration
**`ip a`**  
```
dkofler@ibk-tr-deb00:~$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: ens192: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 00:50:56:93:32:5a brd ff:ff:ff:ff:ff:ff
    inet 172.24.87.100/24 brd 172.24.87.255 scope global ens192
       valid_lft forever preferred_lft forever
    inet6 fe80::250:56ff:fe93:325a/64 scope link 
       valid_lft forever preferred_lft forever
```

### 2. Display the networking config file
**`cat /etc/network/interfaces`** 
```
dkofler@ibk-tr-deb00:~$ cat /etc/network/interfaces
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug ens192
iface ens192 inet static
	address 172.24.87.100/24
	gateway 172.24.87.254
	# dns-* options are implemented by the resolvconf package, if installed
	dns-nameservers 172.24.85.10
	dns-search ntslab.loc
```

### 3. Display the DNS config file
**`cat /etc/resolv.conf`** 
```
dkofler@ibk-tr-deb00:~$ cat /etc/resolv.conf 
domain NTSLAB.loc
search NTSLAB.loc
nameserver 172.24.85.10
nameserver 172.24.85.10
```

### 4. Ping a server thats located outside the network to check DNS resolution
**`ping blog.dot11.org`**

### 5. Change the resolv.conf file to use a differnt nameserver
```
domain NTSLAB.loc
search NTSLAB.loc
nameserver 12.34.56.78
```

### 6. Try to ping the server again
### 7. Add an entry to the /etc/hosts file
```
127.0.0.1	localhost
127.0.1.1	ibk-tr-deb00.ntslab.loc	ibk-tr-deb00
116.203.37.199	blog.dot11.org

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
```
### 8. Try to ping the server again
### 9. Use dig to query a public DNS server
**`dig nts.eu @1.1.1.1`**

### 10. Display the current routes
**`ip route`**
```
dkofler@ibk-tr-deb00:~$ ip route
default via 172.24.87.254 dev ens192 onlink 
172.24.87.0/24 dev ens192 proto kernel scope link src 172.24.87.100 
```

### 11. Display the route to the IP 8.8.8.8
**`ip route get 8.8.8.8`**
```
dkofler@ibk-tr-deb00:~$ ip route get 8.8.8.8
8.8.8.8 via 172.24.87.254 dev ens192 src 172.24.87.100 uid 1000 
```

### 12. Change the nameserver to the correct IP in resolv.conf
### 13. Start up tcpdump and listen on port 8089
**`sudo tcpdump -i 1 port 8089`**
```
dkofler@ibk-tr-deb00:~$ sudo tcpdump -i 1 port 8089
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on ens192, link-type EN10MB (Ethernet), capture size 262144 bytes
18:43:34.517134 IP ibk-tr-deb00.ntslab.loc.54360 > ibk-splunk-dep.ntslab.loc.8089: Flags [S], seq 393999611, win 64240, options [mss 1460,sackOK,TS val 1921404163 ecr 0,nop,wscale 7], length 0
18:43:34.517881 IP ibk-splunk-dep.ntslab.loc.8089 > ibk-tr-deb00.ntslab.loc.54360: Flags [S.], seq 3302418155, ack 393999612, win 65160, options [mss 1460,sackOK,TS val 365861371 ecr 1921404163,nop,wscale 7], length 0
18:43:34.517896 IP ibk-tr-deb00.ntslab.loc.54360 > ibk-splunk-dep.ntslab.loc.8089: Flags [.], ack 1, win 502, options [nop,nop,TS val 1921404164 ecr 365861371], length 0
```