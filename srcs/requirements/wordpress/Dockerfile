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
        wget && \
        rm -rf /var/lib/apt/lists/*

RUN     sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/' /etc/php/8.2/fpm/pool.d/www.conf && \
        sed -i 's/;listen.allowed_clients = 127.0.0.1/listen.allowed_clients = 0.0.0.0/' /etc/php/8.2/fpm/pool.d/www.conf

RUN     mkdir -p /var/www/html && \
        wget https://wordpress.org/latest.tar.gz && \
        tar -xzf latest.tar.gz && \
        rm -rf latest.tar.gz && \
        cp -r wordpress/* /var/www/html/

EXPOSE  9000

CMD     ["php-fpm8.2", "-F"]
