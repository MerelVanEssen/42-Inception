#!/bin/bash

INVALID_NAMES=("admin" "administrator")
ADMIN_LOWERCASE=$(echo "$WP_ADMIN" | tr '[:upper:]' '[:lower:]')

echo "Checking ADMIN NAME...$ADMIN_LOWERCASE"
for INVALID_NAME in "${INVALID_NAMES[@]}"; do
	if [[ "$ADMIN_LOWERCASE" == *"$INVALID_NAME"* ]]; then
		echo "Error: '${WP_ADMIN}' is not a valid username."
		exit 1
	fi
done
echo "Adminname: ${WP_ADMIN} is valid"


# Waiting till mariadb is ready ...
max_attempts=15
attempt=0
while ! nc -zv mariadb 3306; do
	echo "Waiting for mariadb to start ... $attempt"
    attempt=$((attempt + 1))
	sleep 2
	if [ "$attempt" -eq "$max_attempts" ]; then 
        echo "15 attempts, exiting"
        exit 1
    fi 
done


if [ -f /var/www/html/wp-config-sample.php ]; then
	echo "WP is already downloaded, no download needed"
else
	wp-cli.phar core download --allow-root --path=/var/www/html
	echo "WP is downloaded"
fi

if [ ! -f /var/www/html/wp-config.php ]; then
	wp-cli.phar config create --allow-root --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASS} --dbhost=${DB_HOST} --path=/var/www/html
	echo "WP config created for database: ${DB_NAME} with host ${DB_HOST}"

	wp-cli.phar core install --allow-root --skip-email --url=${DOMAIN}/ --title=${TITLE} --admin_user=${ADMIN_USER} --admin_password=${ADMIN_PASS} --admin_email=merel@hotmail.com --path=/var/www/html
	echo "WP Core Installed for domain ${DOMAIN}"

	wp-cli.phar user create --allow-root ${USER} merel1@hotmail.com --user_pass=${USER_PASS} --path=/var/www/html
	echo "WP user: ${USER} created"
fi

# most of the time containers communicate through ports, not unix-sockets
sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

mkdir -p /run/php/

exec /usr/sbin/php-fpm7.4 -F
