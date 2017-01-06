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
apt-key update
apt-get update
apt-get install -y mysql-server 2> /dev/null
apt-get install -y nginx php7.1-fpm php7.1-mysql php7.1-gd php7.1-mcrypt php7.1-curl curl php7.1-mb php7.1-xml php7.1-zip 2> /dev/null

# install phpmyadmin
mkdir -p /var/www/pma/source
mkdir -p /var/www/pma/logs
mkdir -p /var/www/pma/tmp/unpack
wget -O /var/www/pma/tmp/pma.tar.gz https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
tar -xvf /var/www/pma/tmp/pma.tar.gz -C /var/www/pma/tmp/unpack
cp -a /var/www/pma/tmp/unpack/php*/* /var/www/pma/source
rm -rf /var/www/pma/tmp 2> /dev/null

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
