#!/bin/bash

set -e # if error, stop everything


if [ -f "/run/secrets/mysql_root_password" ]; then
  MYSQL_ROOT_PASSWORD=$(cat /run/secrets/mysql_root_password)
else
  echo "Error: mysql_root_password secret not found"
  exit 1
fi

if [ -f "/run/secrets/mysql_password" ]; then
  MYSQL_PASSWORD=$(cat /run/secrets/mysql_password)
else
  echo "Error: mysql_password secret not found"
  exit 1
fi

chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
  mysql_install_db --user=mysql --datadir=/var/lib/mysql # Init BDD for the first time
else
  echo "BDD already exist"
fi

mysqld --user=mysql --datadir=/var/lib/mysql & # Background server

while ! mysqladmin ping --silent 2>/dev/null; do
    echo "Server waiting..."
    sleep 1
done

mysql -e ALTER USER 'root'@'localhost' IDENTIFIED BY mysql_native_password;
mysql -e SET PASSWORD = PASSWORD('${MYSQL_ROOT_PASSWORD}');
mysql -e CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
mysql -e CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
mysql -e GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
mysql -e FLUSH PRIVILEGES;

echo " MariaDB is ready"

wait # Container still running