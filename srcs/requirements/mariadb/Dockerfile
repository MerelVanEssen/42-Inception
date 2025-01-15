FROM debian:bullseye

RUN apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install mariadb-server -y

COPY ./conf/my_mariadb.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/my_mariadb.sh init.sh

RUN mkdir -p /run/mysqld /var/run/mysqld &&\
	chown -R mysql:mysql /var/run/mysqld/ /run/mysqld &&\
	chmod +x /etc/mysql/mariadb.conf.d/50-server.cnf init.sh /run/mysqld/ /var/run/mysqld /run/mysqld

ENTRYPOINT [ "./init.sh" ]

EXPOSE 3306