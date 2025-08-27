#!/bin/bash

set -e

cd /var/www/html

wp core install \
--url="https://$WP_DOMAIN_NAME" \
--title="$WP_TITLE" \
--admin_user="$WP_ADMIN_USER" \
--admin_password="$WP_ADMIN_PASSWORD" \
--admin_email="$WP_ADMIN_EMAIL" \
--allow-root

exec php-fpm8.2 -F