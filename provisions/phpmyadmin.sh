#!/usr/bin/env bash

# install phpmyadmin
mkdir -p /var/www/pma.local/html
mkdir -p /var/www/pma.local/logs
mkdir -p /var/www/pma.local/tmp/unpack
wget -O /var/www/pma.local/tmp/pma.tar.gz https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
tar -xvf /var/www/pma.local/tmp/pma.tar.gz -C /var/www/pma.local/tmp/unpack
cp -a /var/www/pma.local/tmp/unpack/php*/* /var/www/pma.local/html
rm -rf /var/www/pma.local/tmp 2> /dev/null

# Create DATABASE
mysql -u root -p root CREATE DATABASE `vagrant_1` CHARACTER SET utf8 COLLATE utf8_general_ci


# configure phpmyadmin
#mv /var/www/pma.local/html/config.sample.inc.php /var/www/pma.local/html/config.inc.php
#sed -i 's/a8b7c6d/SvbfgkJj54b5gbg/' /var/www/pma.local/html/config.inc.php
#echo "CREATE DATABASE vagrant_1" | mysql -uroot -pROOTPASSWORD
#echo "CREATE USER 'vagrant_1'@'localhost' IDENTIFIED BY 'PMAUSERPASSWD'" | mysql -uroot -pROOTPASSWORD
#echo "GRANT ALL ON vagrant_1.* TO 'vagrant_1'@'localhost'" | mysql -uroot -pROOTPASSWORD
#echo "GRANT ALL ON phpmyadmin.* TO 'vagrant_1'@'localhost'" | mysql -uroot -pROOTPASSWORD
#echo "flush privileges" | mysql -uroot -pROOTPASSWORD
#mysql -D vagrant_1 -u vagrant_1 -pPMAUSERPASSWD < /var/www/pma.local/html/examples/create_tables.sql
#cat /vagrant/phpmyadmin.conf > /var/www/pma.local/html/config.inc.php
