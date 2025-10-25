COMPOSE=docker-compose -f srcs/docker-compose.yml

build:
	$(COMPOSE) build

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down 

logs:
	$(COMPOSE) logs 

clean:
	docker system prune -af

RMVOL:
	sudo rm -rf /home/loay/data/WordPress
	sudo rm -rf /home/loay/data/MariaDB
	docker volume rm srcs_mariadb_data srcs_wordpress_data

show:
	docker ps -a
re: down RMVOL clean build up
.PHONY: build up down logs clean re