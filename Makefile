NAME		= inception

VOLUME1		= "/home/mvan-ess/data/mariadb"
VOLUME2		= "/home/mvan-ess/data/wordpress"
YAML		= "srcs/docker-compose.yml"

all: up

up:	build build_volumes
	docker-compose -f $(YAML) up

down:
	docker-compose -f $(YAML) down

start:
	docker-compose -f $(YAML) start

stop:
	docker-compose -f $(YAML) stop

build:
	docker-compose -f $(YAML) build

build_volumes:
	mkdir -p $(VOLUME1) $(VOLUME2)
	chmod -R 777 $(VOLUME1) $(VOLUME2)
	echo "volume directories are set up"

clean_volumes:
	rm -rf $(VOLUME1)
	rm -rf $(VOLUME2)
	echo "volume directories are removed"

clean: stop
	@if [ "$(docker ps -qa)" ]; then docker stop $(docker ps -qa); fi
	@if [ "$(docker ps -qa)" ]; then docker rm $(docker ps -qa); fi
	@if [ "$(docker images -qa)" ]; then docker rmi -f $(docker images -qa); fi
	@if [ "$(docker volume ls -q)" ]; then docker volume rm $(docker volume ls -q); fi
	@if [ "$(docker network ls -q)" ]; then docker network rm $(docker network ls -q); fi
	@echo "containers, images and network are removed"

re:	clean up

prune: clean clean_volumes
	docker system prune -a --volumes -f