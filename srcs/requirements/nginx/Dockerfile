FROM    debian:bookworm

LABEL   authors="maximart"

RUN     apt-get update -y && apt-get install -y nginx openssl

EXPOSE  443

CMD     ["nginx", "-g", "daemon off;"]