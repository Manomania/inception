#!/bin/bash

set -e # if error, stop everything

mysql_install_db --user=mysql --datadir=/var/lib/mysql # Init BDD for the first time

mysqld --user=mysql & # Background server

mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};" # Create Database
mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
mysql -e "FLUSH PRIVILEGES;"

echo " MariaDB is ready"

wait # Container still running