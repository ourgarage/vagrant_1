#!/usr/bin/env bash

#INSTALL LEMP

#With proxy
#apt-key adv —recv-keys  —keyserver-options http-proxy=http://10.100.1.254:8078 —keyserver keyserver.ubuntu.com 46C2130DFD2497F5
apt-key adv --keyserver-options http-proxy=http://10.100.1.254:8078/ --keyserver keyserver.ubuntu.com --recv-keys 46C2130DFD2497F5

#No proxy
#apt-key adv —recv-keys —keyserver keyserver.ubuntu.com 46C2130DFD2497F5

apt-add-repository ppa:ondrej/php
apt-get update
apt-get install -y nginx mysql-server php7.1-fpm php7.1-mysql php7.1-gd php7.1-mcrypt php7.1-curl curl php7.1-mb php7.1-xml php7.1-zip php-xdebug 2> /dev/null