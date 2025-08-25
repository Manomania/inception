FROM    debian:bookworm

LABEL   authors="maximart"

RUN     apt-get update -y && \
        apt-get install -y mariadb-server && \
        rm -rf /var/lib/apt/lists/*