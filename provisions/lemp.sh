#!/usr/bin/env bash

# Variables
DBHOST=localhost
DBNAME=vagrant_1
DBUSER=vagrant
DBPASSWD=vagrant

# Install LEMP
debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASSWD"
apt-get update
apt-get install -y mysql-server 2> /dev/null
apt-get install -y nginx php7.0-fpm php7.0-mysql php7.0-gd php7.0-mcrypt php7.0-curl curl php7.0-mb php7.0-xml php7.0-zip 2> /dev/null

# Install PHPMYADMIN


# if ! [ -L /var/www ]; then
#   rm -rf /var/www
#   ln -fs /vagrant /var/www
# fi
