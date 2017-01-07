#!/usr/bin/env bash

# Variables
PMA_NAME=pma
DEFAULT_PROJECT=default.dev
DBHOST=localhost
DBNAME=vagrant_1
DBUSER=root
DBPASSWD=root

# Include scripts
NGINX_DEFAULT="server {

    root /home/html/$DEFAULT_PROJECT/public;
    index index.php index.html index.htm;

    location ~ \.php$ {
         try_files $uri /index.php =404;
         fastcgi_pass unix:/var/run/php/php7.1-fpm.sock;
         fastcgi_index index.php;
         fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
         include fastcgi_params;
    }

    location / {
        try_files $uri $uri/ /index.php$is_args$args;
    }

}
"

# Create folders
mkdir -p /var/www/$DEFAULT_PROJECT/ /var/www/$DEFAULT_PROJECT/logs
mkdir -p /var/www/$PMA_NAME/source /var/www/$PMA_NAME/logs /var/www/$PMA_NAME/tmp/unpack

# Install LEMP
debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASSWD"
apt-key update
apt-add-repository ppa:ondrej/php -y
apt-get update
apt-get install -y mysql-server 2> /dev/null
apt-get install -y nginx php7.1-fpm php7.1-mysql php7.1-gd php7.1-mcrypt php7.1-curl curl php7.1-mb php7.1-xml php7.1-zip 2> /dev/null

# install phpmyadmin
wget -O /var/www/$PMA_NAME/tmp/pma.tar.gz https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
tar -xvf /var/www/$PMA_NAME/tmp/pma.tar.gz -C /var/www/$PMA_NAME/tmp/unpack
cp -a /var/www/$PMA_NAME/tmp/unpack/php*/* /var/www/$PMA_NAME/source
rm -rf /var/www/$PMA_NAME/tmp 2> /dev/null

# Create DATABASE
cat > /root/.my.cnf << EOF
[client]
user = root
password = root
host = localhost
EOF
cp /root/.my.cnf /var/www/pma/.my.cnf
mysql -e "CREATE DATABASE VAGRANT_1 CHARACTER SET utf8 DEFAULT COLLATE utf8_unicode_ci";

# Install GIT
apt-get install -y git 2> /dev/null

# SSH key
#config.ssh.insert_key = false
  #config.ssh.private_key_path = ["keys/private", "~/.vagrant.d/insecure_private_key"]
  #config.vm.provision "file", source: "keys/public", destination: "~/.ssh/authorized_keys"
  #config.vm.provision "shell", inline: <<-EOC
    #sudo sed -i -e "\\#PasswordAuthentication yes# s#PasswordAuthentication yes#PasswordAuthentication no#g" /etc/ssh/sshd_config
    #sudo service ssh restart
  #EOC

# Add lines to hosts file

 echo "127.0.0.1 $PMA_NAME" >> /etc/hosts
 echo "127.0.0.1 $DEFAULT_PROJECT" >> /etc/hosts

# NGINX setting
 echo "$NGINX_DEFAULT" > /etc/nginx/sites-available/default