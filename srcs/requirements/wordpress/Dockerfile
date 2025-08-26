FROM    debian:bookworm

LABEL   authors="maximart"

RUN     apt-get update -y && \
        apt-get install -y \
        php-fpm \
        curl \
        dom \
        exif \
        fileinfo \
        hash \
        igbinary \
        imagick \
        intl \
        json \
        mbstring \
        pcre \
        xml \
        zip \

#RUN    sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/' /etc/php/8.2/fpm/pool.d/www.conf && \
#       sed -i 's/;listen.allowed_clients = 127.0.0.1/listen.allowed_clients = 0.0.0.0/' /etc/php/8.2/fpm/pool.d/www.conf && \
#       sed -i 's/pm.max_children = 5/pm.max_children = 20/' /etc/php/8.2/fpm/pool.d/www.conf && \
#        sed -i 's/pm.max_requests = 500/pm.max_requests = 200/' /etc/php/8.2/fpm/pool.d/www.conf


EXPOSE  9000
