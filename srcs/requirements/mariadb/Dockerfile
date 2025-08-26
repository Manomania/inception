FROM    debian:bookworm

LABEL   authors="maximart"

RUN     apt-get update -y && \
        apt-get install -y mariadb-server && \
        rm -rf /var/lib/apt/lists/* && \
        sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf \
        mkdir -p /run/mysqld

COPY    /conf/init_db.sh /usr/local/bin/init_db.sh
RUN     chmod +x /usr/local/bin/init_db.sh

EXPOSE  3306

CMD     ["/usr/local/bin/init_db.sh"]