FROM debian:bullseye

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install php -y && \
    apt-get install php-fpm -y && \
    apt-get install php-mysql -y && \
    apt-get install php-curl  -y && \
    apt-get install php-xml -y && \
    apt-get install php-mbstring -y && \
    apt-get install php-zip -y && \
    apt-get install php-cli -y && \
    apt-get install curl -y && \
    apt-get install unzip -y && \
    apt-get install netcat -y && \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp-cli.phar && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY /tools/my_wordpress.sh wordpress.sh

RUN chmod +x wordpress.sh

EXPOSE 9000

ENTRYPOINT [ "./wordpress.sh" ]