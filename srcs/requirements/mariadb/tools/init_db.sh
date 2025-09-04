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

if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
  echo "Initializing database..."
  mysql_install_db --user=mysql --datadir=/var/lib/mysql
  mysqld --user=mysql --datadir=/var/lib/mysql & # background server
  MYSQL_PID=$!

  while ! mysqladmin ping --silent 2>/dev/null; do
      echo "Waiting for MySQL to start..."
      sleep 2
  done

  mysql << EOF
ALTER USER 'root'@'localhost' IDENTIFIED VIA mysql_native_password;
SET PASSWORD = PASSWORD('${MYSQL_ROOT_PASSWORD}');
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
CREATE USER IF NOT EXISTS 'healthcheck'@'localhost';
GRANT USAGE ON *.* TO 'healthcheck'@'localhost';
FLUSH PRIVILEGES;
EOF

  kill $MYSQL_PID
  wait $MYSQL_PID

  echo "Database initialization complete"
else
  echo "Database already exists"
fi

echo "Starting MySQL server..."
exec mysqld --user=mysql --datadir=/var/lib/mysql