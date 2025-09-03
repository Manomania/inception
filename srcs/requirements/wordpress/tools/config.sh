#!/bin/bash

set -e

cd /var/www/html

if [ -f "/run/secrets/wp_admin_user" ]; then
  WP_ADMIN_USER=$(cat /run/secrets/wp_admin_user)
else
  echo "Error: wp_admin_user secret not found"
  exit 1
fi

if [ -f "/run/secrets/wp_admin_password" ]; then
  WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
else
  echo "Error: wp_admin_password secret not found"
  exit 1
fi

if [ -f "/run/secrets/wp_admin_email" ]; then
  WP_ADMIN_EMAIL=$(cat /run/secrets/wp_admin_email)
else
  echo "Error: wp_admin_email secret not found"
  exit 1
fi

wp core install \
--url="https://$WP_DOMAIN_NAME" \
--title="$WP_TITLE" \
--admin_user="$WP_ADMIN_USER" \
--admin_password="$WP_ADMIN_PASSWORD" \
--admin_email="$WP_ADMIN_EMAIL" \
--allow-root

exec php-fpm8.2 -F