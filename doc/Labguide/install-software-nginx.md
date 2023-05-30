# Install nginx
## Commands
| Command | Description |
| --- | --- |
| apt | debian package manager |
| systemctl| start / stop / status of processes |
| netstat | show open ports and network connections |
---

## Tasks
### 1. Update the apt repository
**`sudo apt update`**  

### 2. Install nginx
**`sudo apt install nginx`**  

### 3. Check if the nginx service is running
**`sudo systemctl status nginx.service`**

### 4. Stop the nginx service
### 5. Create a new directory /var/www/ntslab/html
### 6. Create a new file called **index.html** in /var/www/ntslab/html with the content
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <title>NTSLab Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>

<div class="jumbotron text-center">
  <h1>NTSLab example page</h1>
  <p>Awesome, its responsive!</p> 
</div>
  
<div class="container">
  <div class="row">
    <div class="col-sm-4">
      <h3>NTSLab</h3>
      <p>This website runs on a Linux server using nginx webserver</p>
      <p>You did it! Was not that hard, wasn't it?</p>
    </div>
    <div class="col-sm-4">
      <h3>Github</h3>
      <p>Jump to the Github Labguide for more info</p>
      <p><a href="https://github.com/fox27374/linux-basics">Linux Basics</a></p>
    </div>
    <div class="col-sm-4">
      <h3>Nginx</h3>        
      <p>For more info on the nginx project go to ...</p>
      <p><a href="https://www.nginx.com/">www.nginx.com</a></p>
    </div>
  </div>
</div>

</body>
</html>
```

### 7. Create a new file called **ntslab** in /etc/nginx/sites-available/ with the content
```
server {
        listen 80;
        listen [::]:80;

        root /var/www/ntslab/html;
        index index.html index.htm;

        server_name ntslab.loc;

        location / {
                try_files $uri $uri/ =404;
        }
}
```
### 8. Enable the configuration by creating a link
**`sudo ln -s /etc/nginx/sites-available/ntslab /etc/nginx/sites-enabled/`**

### 9. Remove the default configuration
**`sudo rm /etc/nginx/sites-enabled/default`**

### 10. Start the nginx service
### 11. Find the port that nginx is listening on
### 12. Open a browser and visit your new website (replace XX with your student number)
**`http://ibk-lnx-trXX.ntslab.loc:<PORT>`**

### 13. In your home directory, create a link to the html folder
**`ln -s /var/www/ntslab/html html`**

### 14. Edit the file directly using the link
**`sudo vi html/index.html`**

### 15. Add somthing cool to the html page and check the result
