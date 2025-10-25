#!/usr/bin/env bash
# Setup WordPress installation
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
WP_SRC_DIR="/var/www/html"
cd $WP_SRC_DIR && chmod -R 755 $WP_SRC_DIR
sed -i 's|^listen = .*|listen = 9000|' "/etc/php/7.4/fpm/pool.d/www.conf"
wp core download --allow-root
wp config create --dbname=${DATABASE_NAME} --dbuser=${DATABASE_USER} --dbpass=${DATABASE_PASSWORD} --dbhost=${DATABASE_HOST} --allow-root
wp core install --url=${DOMAIN_NAME} --title=${WP_TITLE} --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --allow-root
wp user create ${WP_USER} ${WP_USER_EMAIL} --user_pass=${WP_PASSWORD} --role=${WP_USER_ROLE} --allow-root
wp theme install twentytwentyfive --activate --allow-root
chown -R www-data:www-data $WP_SRC_DIR
mkdir -p /run/php
php-fpm7.4 -F