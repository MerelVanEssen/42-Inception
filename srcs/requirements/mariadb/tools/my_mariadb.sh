#!/bin/sh

echo "Create mariadb database with name: ${DB_NAME}   and user: ${DB_USER}"

mysqld_safe --skip-grant-tables &

max_attempts=15
attempt=0

while ! mysqladmin ping --silent; do
    echo "Waiting for MariaDB to start ... $attempt"
    attempt=$((attempt + 1))
    sleep 2
    if [ "$attempt" -eq "$max_attempts" ]; then 
        echo "15 attempts, exiting"
        exit 1
    fi 
done

mysql -u root -p${DB_PASS} -e "FLUSH PRIVILEGES;"
mysql -u root -p${DB_PASS} -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
mysql -u root -p${DB_PASS} -e "CREATE USER IF NOT EXISTS \`${DB_USER}\`@'localhost' IDENTIFIED BY '${DB_PASS}';"
mysql -u root -p${DB_PASS} -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_PASS}';"
mysql -u root -p${DB_PASS} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_PASS}';"
mysql -u root -p${DB_PASS} -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p${DB_PASS} shutdown

exec mysqld
