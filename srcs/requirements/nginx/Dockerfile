FROM    debian:bookworm

LABEL   authors="maximart"

RUN     apt-get update -y && \
        apt-get install -y nginx openssl && \
        rm -rf /var/lib/apt/lists/* && \
        openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout certificat.key \
        -out certificat.crt \
        -subj "/C=FR/L=Paris/O=42/CN=maximart.42.fr"

COPY    conf/nginx.conf /etc/nginx/sites-enabled/default

EXPOSE  443

CMD     ["nginx", "-g", "daemon off;"]