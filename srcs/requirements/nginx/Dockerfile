FROM    debian:bookworm

LABEL   authors="maximart"

RUN     apt-get update -y && \
        apt-get install -y nginx openssl && \
        rm -rf /var/lib/apt/lists/*

RUN     mkdir -p /etc/nginx/ssl

RUN     openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/certificat.key \
        -out /etc/nginx/ssl/certificat.crt \
        -subj "/C=FR/L=Paris/O=42/CN=maximart.42.fr"

COPY    conf/nginx.conf /etc/nginx/sites-available/default

RUN     ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

RUN     mkdir -p /var/www/html

EXPOSE  443

CMD     ["nginx", "-g", "daemon off;"]