FROM    debian:bookworm

LABEL   authors="maximart"

RUN     apt-get update -y && \
        apt-get install -y redis-server && \
        rm -rf /var/lib/apt/lists/*

COPY    conf/redis.conf /etc/redis/redis.conf

EXPOSE  6379

CMD     ["redis-server", "--protected-mode", "no"]