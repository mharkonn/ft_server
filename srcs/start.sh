#!/bin/bash

# phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xf phpMyAdmin-4.9.0.1-all-languages.tar.gz
mv /phpMyAdmin-4.9.0.1-all-languages /var/www/html/phpmyadmin
mv /tmp/config.inc.php /var/www/html/phpmyadmin/config.inc.php

# nginx
mv /tmp/default /etc/nginx/sites-available/default
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

#enable autoindex
mkdir /var/www/autoindex
mv /tmp/autoindex_on.sh .
mv /tmp/autoindex_off.sh .
mv /tmp/default /var/www/autoindex/

# ssl
mkdir /etc/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout mharkonn.key \
 -out mharkonn.crt -subj "/C=RU/ST=Tatarstan/L=Kazan/O=school21/CN=mharkonn"
mv mharkonn.key /etc/ssl/
mv mharkonn.crt /etc/ssl/

# wordpress
wget https://wordpress.org/latest.tar.gz
tar -xf latest.tar.gz
rm latest.tar.gz
mv wordpress /var/www/html/
mv /tmp/wp-config.php /var/www/html/wordpress/wp-config.php

# access rights
chown -R www-data /var/www/html
chmod -R 755 /var/www/html

service mysql start
service php7.3-fpm start
service nginx start

# mysql
mysql -e "CREATE DATABASE wordpress; \
CREATE USER 'mharkonn'@'localhost' IDENTIFIED BY '123';  \
GRANT ALL PRIVILEGES ON wordpress.* TO 'mharkonn'@'localhost' IDENTIFIED BY '123'; \
FLUSH PRIVILEGES;"
bash
