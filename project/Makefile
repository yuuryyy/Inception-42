###########################################################################
#                                 COLORS
#          For providing clear, color-coded feedback to the user.
###########################################################################

# Terminal color escape codes
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

# The base docker-compose command. Using a variable keeps rules clean and easy to manage.
# The -p flag isolates this project's containers, networks, and volumes.
COMPOSE         := docker compose -f $(COMPOSE_FILE) -p $(COMPOSE_PROJECT)

# Default rule to run when `make` is invoked without a target.
.DEFAULT_GOAL := all

# Declare targets that are not files. This prevents conflicts with files of the
# same name and improves performance by avoiding filesystem checks.
.PHONY: all build clean fclean re exec it ps list_containers list_images list_volumes list_networks

###########################################################################
#                               BASIC RULES
#        Core commands for building, cleaning, and resetting the environment.
###########################################################################

# Build and start all services in detached mode.
all: build

# Stop and remove the project's containers and default network.
clean:
	@echo  "$(YELLOW)Stopping and removing containers for project '$(COMPOSE_PROJECT)'...$(RESET)"
	@$(COMPOSE) down

# Perform a "full clean": stop containers and remove all associated
# images, volumes, and networks. This ensures a completely fresh start.
fclean: clean
	@echo  "$(RED)Performing deep clean: removing images, volumes, and networks...$(RESET)"
	@$(COMPOSE) down --rmi all --volumes
	@echo  "$(GREEN)Project fully cleaned.$(RESET)"

# A convenient shortcut to completely reset and rebuild the environment.
re: fclean all
	@echo  "$(GREEN)Project has been completely rebuilt and restarted.$(RESET)"

###########################################################################
#                              COMPLEX RULES
#          More advanced targets for interacting with the services.
###########################################################################

# Build (or rebuild) images and start all services in the background.
# The `mkdir` commands prevent Docker from creating root-owned directories for bind mounts.
build:
	@echo  "$(BLUE)Creating host directories for persistent data...$(RESET)"
	@mkdir -p ~/data/wordpress
	@mkdir -p ~/data/mariadb
	@echo  "$(BLUE)Building images and starting services for project '$(COMPOSE_PROJECT)'...$(RESET)"
	@$(COMPOSE) up --build -d
	@echo  "$(GREEN)Project is up and running!$(RESET)"

# Execute a command inside a specified service container.
# Usage: make exec service=<service_name> cmd="<command>"
# Example: make exec service=wordpress cmd="ls -l /var/www/html"
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

# Open an interactive shell (/bin/bash) inside a specified service container.
# Usage: make it service=<service_name>
# Example: make it service=mariadb
it:
	@if [ -z "$(service)" ]; then \
		echo "$(RED)Error: 'service' is not set. Usage: make it service=<service_name>$(RESET)"; \
		exit 1; \
	fi
	@echo  "$(BLUE)Opening interactive shell in service '$(service)'...$(RESET)"
	@$(COMPOSE) exec $(service) /bin/bash

###########################################################################
#                         INFORMATION & LISTING RULES
#          Targets for inspecting the state of the Docker environment.
###########################################################################

# A meta-target to display all resources associated with this project.
list: list_containers list_images list_volumes list_networks

list_containers:
	@echo  "$(BLUE)--- Containers for project '$(COMPOSE_PROJECT)' ---$(RESET)"
	@$(COMPOSE) ps

list_images:
	@echo  "$(BLUE)--- Images for project '$(COMPOSE_PROJECT)' ---$(RESET)"
	@$(COMPOSE) images

list_volumes:
	@echo  "$(BLUE)--- Volumes for project '$(COMPOSE_PROJECT)' ---$(RESET)"
	@docker volume ls --filter "label=com.docker.compose.project=$(COMPOSE_PROJECT)"

list_networks:
	@echo  "$(BLUE)--- Networks for project '$(COMPOSE_PROJECT)' ---$(RESET)"
	@docker network ls --filter "label=com.docker.compose.project=$(COMPOSE_PROJECT)"