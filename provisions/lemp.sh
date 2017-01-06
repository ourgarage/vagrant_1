#!/usr/bin/env bash

# Variables
DBHOST=localhost
DBNAME=vagrant_1
DBUSER=root
DBPASSWD=root

# Install LEMP
apt-add-repository ppa:ondrej/php -y
debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASSWD"
apt-get update
apt-get install -y mysql-server 2> /dev/null
apt-get install -y nginx php7.1-fpm php7.1-mysql php7.1-gd php7.1-mcrypt php7.1-curl curl php7.1-mb php7.1-xml php7.1-zip 2> /dev/null
