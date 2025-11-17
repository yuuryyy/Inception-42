###########################################################################
#                                 COLORS
#          For providing clear, color-coded feedback to the user.
###########################################################################

RESET   := \033[0m
RED     := \033[0;31m
GREEN   := \033[0;32m
YELLOW  := \033[0;33m
BLUE    := \033[0;34m

###########################################################################
#                              COMPOSE INFO
#     Centralized configuration for Docker Compose commands.
###########################################################################

COMPOSE_FILE    := ./srcs/docker-compose.yml

COMPOSE_PROJECT := inception_42

COMPOSE         := docker compose -f $(COMPOSE_FILE) -p $(COMPOSE_PROJECT)


.PHONY: all build clean fclean re exec it ps list_containers list_images list_volumes list_networks

###########################################################################
#                               BASIC RULES
#        Core commands for building, cleaning, and resetting the environment.
###########################################################################

all: build

clean:
	@echo  "$(YELLOW)Stopping and removing containers for project '$(COMPOSE_PROJECT)'...$(RESET)"
	@$(COMPOSE) down

fclean: clean
	@echo  "$(RED)Performing deep clean: removing all volumes and networks...$(RESET)"

	@docker volume rm $(COMPOSE_PROJECT)_mariadb_data $(COMPOSE_PROJECT)_wordpress_files || true
# 	@docker network rm $(COMPOSE_PROJECT)_inception || true
	@echo  "$(GREEN)Project fully cleaned.$(RESET)"

re: fclean all
	@echo  "$(GREEN)Project has been completely rebuilt and restarted.$(RESET)"

###########################################################################
#                              COMPLEX RULES
#          More advanced targets for interacting with the services.
###########################################################################

build:
	@echo  "$(BLUE)Creating host directories for persistent data...$(RESET)"
	@mkdir -p ~/data/wordpress
	@mkdir -p ~/data/mariadb
	@echo  "$(BLUE)Building images and starting services for project '$(COMPOSE_PROJECT)'...$(RESET)"
	@$(COMPOSE) up --build -d
	@echo  "$(GREEN)Project is up and running!$(RESET)"


exec:
	@if [ -z "$(service)" ]; then \
		echo "$(RED)Error: 'service' is not set. Usage: make exec service=<service_name> cmd=\"<command>\"$(RESET)"; \
		exit 1; \
	fi
	@if [ -z "$(cmd)" ]; then \
		echo "$(RED)Error: 'cmd' is not set. Usage: make exec service=<service_name> cmd=\"<command>\"$(RESET)"; \
		exit 1; \
	fi
	@echo  "$(BLUE)Executing '$(cmd)' in service '$(service)'...$(RESET)"
	@$(COMPOSE) exec $(service) $(cmd)

it:
	@if [ -z "$(service)" ]; then \
		echo "$(RED)Error: 'service' is not set. Usage: make it service=<service_name>$(RESET)"; \
		exit 1; \
	fi
	@echo  "$(BLUE)Opening interactive shell in service '$(service)'...$(RESET)"
	@$(COMPOSE) exec $(service) /bin/bash

logs:
	@if [ -z "$(service)" ]; then \
		echo "$(RED)Error: 'service' is not set. Usage: make logs service=<service_name>$(RESET)"; \
		exit 1; \
	fi
	@echo  "$(BLUE)Opening logs for '$(service)'...$(RESET)"
	@$(COMPOSE) logs $(service) 

###########################################################################
#                         INFORMATION & LISTING RULES
#          Targets for inspecting the state of the Docker environment.
###########################################################################

list: list_containers list_images list_volumes list_networks

list_containers:
	@echo  "$(BLUE)--- Containers for project '$(COMPOSE_PROJECT)' ---$(RESET)"
	@$(COMPOSE) ps

list_images:
	@echo  "$(BLUE)--- Images for project '$(COMPOSE_PROJECT)' ---$(RESET)"
	@$(COMPOSE) images


list_volumes:
	@echo  "$(BLUE)--- Volumes for project '$(COMPOSE_PROJECT_NAME)' ---$(RESET)"
	@docker volume ls --filter "name=$(COMPOSE_PROJECT_NAME)"

list_networks:
	@echo  "$(BLUE)--- Networks for project '$(COMPOSE_PROJECT_NAME)' ---$(RESET)"
	@docker network ls --filter "name=$(COMPOSE_PROJECT_NAME)"

############################################################################
#						GITHUB MANAGEMENT
#
###########################################################################
push:
	git status
	git add .
	git commit -m "$(filter-out $@, $(MAKECMDGOALS))"
	git push

commit:
	git status
	git add .
	git commit -m "$(filter-out $@, $(MAKECMDGOALS))"