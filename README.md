# 42-Inception
multi container application

## Connecting 3 self-written contianers incl network and volume:
- Mariadb
- NGINX
- Wordpress

## Features
- Docker
- Docker-compose
- sh scripts
- system administration
- vm

## Getting started
- sudo apt-get update
- sudo apt-get install ca-certificates curl
- sudo install -m 0755 -d /etc/apt/keyrings
- sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
- sudo chmod a+r /etc/apt/keyrings/docker.asc
- sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

## Installation
- git clone git@github.com:MerelVanEssen/42-Inception.git inception
- cd inception
- sudo make
- browser: https://mvan-ess.42.fr
