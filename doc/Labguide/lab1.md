# Setup an on premises wordpress site
## Commands
Use the following commands to navigate through the filesystem:

| Command | Description |
| --- | --- |
| wget | transfer files from url |
| tar | compress / extract files |
| chown | change file / directory owner |
| chmod | modify file / directory permissions |
| netstat | show open ports and network connections |
| systemctl | controll processes |
| docker | container runtime |
---
This lab mainly follows [this](https://www.tecmint.com/install-wordpress-in-ubuntu-lamp-stack/) guide.
## Tasks
## Server 1 ##
### 1. Install apache webserver
**`sudo apt install apache2 apache2-utils`**  

### 2. Check if the webserver is running
**`sudo systemctl status apache2.service`**  

### 3. Check the open ports
**`sudo netstat -tulpn | grep apache`**

### 4. Check if you can reach the webserver from the internet
**`http://<BASTION IP>:80XX`** 

## Server 2 ##
### 1. Install mysql server via docker
**`docker run --name wordpress-mysql -e MYSQL_ROOT_PASSWORD=<ROOT PASWORD> --rm -p 3306:3306 -d mysql:latest`**  

### 2. exec into the mysql container
**`docker exec -it wordpress-mysql mysql -u root -p`**  

### 3. Create a table, user and privileges for the wordpress website
**`create table wordpress;`**  
**`CREATE USER 'wp_user'@'%' IDENTIFIED WITH mysql_native_password BY '<WP USER PASSWORD>';`** 
**`GRANT ALL ON wordpress.* TO 'wp_user'@'%';`**  
**`FLUSH PRIVILEGES;`**  

### 4. Exit the container
**`exit;`** 

## Server 1 ##
### 1. Stop the webserver
**`sudo systemctl stop apache2.service`**  

### 2. Install additional packages needed for wordpress
**`sudo apt install php libapache2-mod-php php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip`**  

### 4. Download the latest wordpress files
**`wget -c http://wordpress.org/latest.tar.gz`**  

### 5. Extract the compressed file
### 6. Copy the content to the web content directory /var/www/html/

### 7. Change the file owner and permissions
**`sudo chown -R www-data:www-data /var/www/html/`**  
**`sudo chmod -R 755 /var/www/html/`**  

### 8. Rename the wordpress sample config and delete the default index file
**`cd /var/www/html/`**  
**`sudo mv wp-config-sample.php wp-config.php`**  
**`sudo rm -rf index.html`** 

### 9. Edit the file wp-config.php and set the values for the DB connection
* DB_NAME: wordpress
* DB_USER: wp_user
* DB_PASSWORD: `<DB ROOT PASSWORD>`
* DB_HOST: `<Server2 IP>`

### 10. Add the following code to the file (because of the reverse proxy)
```sh
if (!empty($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') {
        $_SERVER['HTTPS'] = 'on';
        $_SERVER['SERVER_PORT'] = 443;
}

if (!empty($_SERVER['HTTP_X_FORWARDED_HOST'])) {
        $_SERVER['HTTP_HOST'] = $_SERVER['HTTP_X_FORWARDED_HOST'];
}
```

### 11. Start the webserver
### 12. Check if the website works

