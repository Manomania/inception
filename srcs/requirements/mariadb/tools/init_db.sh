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

FIRST_RUN=false
mysqld --user=mysql --datadir=/var/lib/mysql & # Background server
FIRST_RUN=true
while ! mysqladmin ping --silent 2>/dev/null; do
    echo "Server waiting..."
    sleep 1
done

if [ "$FIRST_RUN" = true ]; then
  echo "Init configuration"
  mysql << EOF
GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF
  echo "Init finished"
else
  echo "DB already exist, starting normaly"
fi

echo " MariaDB is ready"

wait # Container still running