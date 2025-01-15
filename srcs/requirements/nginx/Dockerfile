FROM debian:bullseye

RUN apt-get update -y && \
	apt-get upgrade -y && \
	apt install nginx -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

COPY conf/my_nginx.conf /etc/nginx/nginx.conf

COPY tools/my_nginx.sh /usr/local/bin/nginx.sh 

COPY tools /etc/nginx/ssl

RUN chmod +x /usr/local/bin/nginx.sh &&\
	chmod +x /etc/nginx/nginx.conf &&\
	chmod 600 /etc/nginx/ssl

EXPOSE 443

ENTRYPOINT [ "./usr/local/bin/nginx.sh"]
