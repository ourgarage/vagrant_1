#!/usr/bin/env bash

# User setup

# Variables
DBHOST=localhost
DBUSER=root
DBPASSWD=root

NGINX_PMA="server {
    listen 80;
    server_name pma;
    access_log /var/www/pma/logs/access.log;
    error_log /var/www/pma/logs/error.log;
    autoindex off;
    allow all;
 
   location ~ \.php$ {
        try_files $uri =404;
        root /var/www/pma/source/;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/var/run/php/php7.1-fpm.sock;
        include fastcgi.conf;
    }
    location / {
        root /var/www/pma/source/;
        index  index.php index.html;
    }
}
"

mkdir -p /var/www/pma/source /var/www/pma/logs /var/www/pma/tmp/unpack

# Install LEMP
apt-get purge apache2 -у 2> /dev/null
debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASSWD"
apt-add-repository ppa:ondrej/php -y
apt-key update
apt-get update
apt-get install -y nginx mysql-server php7.1-fpm php7.1-mysql php7.1-gd php7.1-mcrypt php7.1-curl curl php7.1-mb php7.1-xml php7.1-zip php-xdebug 2> /dev/null

# install phpmyadmin
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

cp /root/.my.cnf /home/it/.my.cnf

# Install GIT
apt-get install -y git 2> /dev/null

# NGINX & PHP settings
echo $NGINX_PMA > /etc/nginx/sites-available/pma.conf
ln -s /etc/nginx/sites-available/pma.conf /etc/nginx/sites-enabled/pma.conf

sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.0/fpm/php.ini

service nginx restart
service php7.1-fpm restart

# REDIS
apt-get -y install build-essential tcl redis-server 2> dev/null
    #sudo nano /etc/redis/redis.conf
    #Меняем supervised no   на    supervised systemd
    #Меняем dir ./   на    dir /var/lib/redis
echo "$REDIS" > /etc/systemd/system/redis.service
adduser --system --group --no-create-home redis
mkdir /var/lib/redis
chown redis:redis /var/lib/redis
chmod 770 /var/lib/redis
systemctl start redis
systemctl status redis
systemctl enable redis
 
# CRON
# mkdir /etc/cron.d 2>/dev/null
# echo "* * * * * php /var/www/$DEFAULT_PROJECT/html/artisan schedule:run >> /dev/null 2>&1" > /etc/cron.d/1111
# service cron restart
 
# NODE & YARN & GULP
curl -sL https://deb.nodesource.com/setup_7.x | -E bash -
apt-get install -y nodejs
apt-get install npm

sudo ln -s "$(which nodejs)" /usr/bin/node

npm install --global gulp-cli
 
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
apt-get update
apt-get -y install yarn
 