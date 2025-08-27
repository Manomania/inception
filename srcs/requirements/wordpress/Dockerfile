FROM    debian:bookworm

LABEL   authors="maximart"

RUN     apt-get update -y && \
        apt-get install -y \
        php-fpm \
        php-json \
        php-mysql \
        php-curl \
        php-xml \
        php-exif \
        php-fileinfo \
        php-igbinary \
        php-imagick \
        php-intl \
        php-mbstring \
        php-zip \
        wget \
        curl && \
        rm -rf /var/lib/apt/lists/*


RUN     sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/g' /etc/php/8.2/fpm/pool.d/www.conf && \
        echo "clear_env = no" >> /etc/php/8.2/fpm/pool.d/www.conf

RUN     mkdir -p /var/www/html && \
        wget https://wordpress.org/latest.tar.gz && \
        tar -xzf latest.tar.gz && \
        rm -rf latest.tar.gz && \
        mv wordpress/* /var/www/html/ && \
        chown -R www-data:www-data /var/www/html && \
        chmod -R 755 /var/www/html

RUN     curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
        chmod +x wp-cli.phar && \
        mv wp-cli.phar /usr/local/bin/wp && \
        wp core install --url="https://$WP_DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --allow-root

COPY    /conf/wp-config.php /var/www/html/wp-config.php

RUN     chown www-data:www-data /var/www/html/wp-config.php

EXPOSE  9000

CMD     ["php-fpm8.2", "-F"]

