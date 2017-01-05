#!/usr/bin/env bash

# install phpmyadmin
mkdir -p /var/www/pma.local/html
mkdir -p /var/www/pma.local/logs
wget -O /var/www/pma.local/html/pma.tar.gz https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
tar -xvf /var/www/pma.local/html/pma.tar.gz -C /var/www/pma.local/html
rm /var/www/pma.local/html/pma.tar.gz 2> /dev/null

# configure phpmyadmin
mv /var/www/pma.local/html/config.sample.inc.php /var/www/pma.local/html/config.inc.php
sed -i 's/a8b7c6d/NEWBLOWFISHSECRET/' /var/www/pma.local/html/config.inc.php
echo "CREATE DATABASE pma" | mysql -uroot -pROOTPASSWORD
echo "CREATE USER 'pma'@'localhost' IDENTIFIED BY 'PMAUSERPASSWD'" | mysql -uroot -pROOTPASSWORD
echo "GRANT ALL ON pma.* TO 'pma'@'localhost'" | mysql -uroot -pROOTPASSWORD
echo "GRANT ALL ON phpmyadmin.* TO 'pma'@'localhost'" | mysql -uroot -pROOTPASSWORD
echo "flush privileges" | mysql -uroot -pROOTPASSWORD
mysql -D pma -u pma -pPMAUSERPASSWD < /var/www/pma.local/html/examples/create_tables.sql
cat /vagrant/phpmyadmin.conf > /vagrant/myadm.localhost/config.inc.php
