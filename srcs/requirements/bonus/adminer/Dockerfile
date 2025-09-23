FROM    debian:bookworm

LABEL   authors="maximart"

RUN     apt-get update -y && \
        apt-get install -y wget php php-mysql && \
        rm -rf /var/lib/apt/lists/*

CMD     [ "php", "-S", "0.0.0.0:8080", "-t", "var/www/html" ]