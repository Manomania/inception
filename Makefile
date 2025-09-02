########################################################################################################################
#                                                      VARIABLES                                                       #
########################################################################################################################

AUTHOR				:=	maximart
PROJECT_NAME		:=	inception

COMPOSE_F			:=	docker-compose
COMPOSE				=	$(addprefix $(COMPOSE_DIR), $(addsuffix .yml, $(COMPOSE_F)))
DOCKER_BUILD_ARGS	=	--build-arg BUILD_DATE="$(BUILD_DATE)" \
						--build-arg VERSION="$(VERSION)" \
						--build-arg AUTHOR="$(AUTHOR)"
BUILD_DATE			:=	$(shell date '+%Y-%m-%d %H:%M:%S')
VERSION				:=	$(shell git describe --tags --always 2>/dev/null || echo "unknown")
NPROCS				:=	$(shell nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 1)
UNAME_S				:=	$(shell uname -s 2>/dev/null || echo "Unknown")

########################################################################################################################
#                                                      DIRECTORY                                                       #
########################################################################################################################

COMPOSE_DIR				:=	srcs/
DATA_DIR				:=	$(COMPOSE_DIR)requirements/
MARIADB_DIR				:=	$(DATA_DIR)/mariadb
NGINX_DIR				:=	$(DATA_DIR)/nginx
WORDPRESS_DIR			:=	$(DATA_DIR)/wordpress

########################################################################################################################
#                                                       TARGETS                                                        #
########################################################################################################################

.print_header:
							$(call DISPLAY_TITLE)
							$(call SEPARATOR)
							$(call BUILD)
							$(call SEPARATOR)

all:					.print_header build up

build:					.print_header
							@docker compose -f $(COMPOSE) build $(DOCKER_BUILD_ARGS)

up: 					.print_header
							@docker compose -f $(COMPOSE) up -d

down: 					.print_header
							@docker compose -f $(COMPOSE) down

start:					.print_header
							@docker compose -f $(COMPOSE) start

stop:					.print_header
							@docker compose -f $(COMPOSE) stop

restart:				.print_header
							@docker compose -f $(COMPOSE) restart

reset:					fclean build up

clean:					.print_header
							@docker compose -f $(COMPOSE) down --remove-orphans
							@docker image prune -f
							@docker volume prune -f

fclean:					.print_header clean
							@docker image prune -a -f
							@docker volume prune -a -f

help:
							$(call DISPLAY_HELP)

info:
							$(call DISPLAY_INFO)

.PHONY: 				all build up down start stop restart clean fclean help info

########################################################################################################################
#                                                       COLOURS                                                        #
########################################################################################################################

DEF_COLOR			:=	\033[0;39m
ORANGE				:=	\033[0;33m
GRAY				:=	\033[0;90m
RED					:=	\033[0;91m
GREEN				:=	\033[1;92m
YELLOW				:=	\033[1;93m
BLUE				:=	\033[0;94m
MAGENTA				:=	\033[0;95m
CYAN				:=	\033[0;96m
WHITE				:=	\033[0;97m
PURPLE				:=	\033[0;35m

########################################################################################################################
#                                                       DISPLAY                                                        #
########################################################################################################################

#TITLE ASCII ART - SLANT
define	DISPLAY_TITLE
						@echo "$(RED)	       _____   __________________  ______________  _   __"
						@echo "$(ORANGE)	      /  _/ | / / ____/ ____/ __ \/_  __/  _/ __ \/ | / /"
						@echo "$(YELLOW)	      / //  |/ / /   / __/ / /_/ / / /  / // / / /  |/ / "
						@echo "$(GREEN)	    _/ // /|  / /___/ /___/ ____/ / / _/ // /_/ / /|  /  "
						@echo "$(BLUE)           /___/_/ |_/\____/_____/_/     /_/ /___/\____/_/ |_/   "
						@printf "$(PURPLE)$(DEF_COLOR)"
endef

define	SEPARATOR
						@printf "\n"
						@echo "$(ORANGE)--------------------------------------------------------------------------$(DEF_COLOR)";
						@printf "\n"
endef

define	BUILD
						@printf "%-47b%b" "$(GREEN)AUTHOR:$(DEF_COLOR)" "$(AUTHOR)\n";
						@printf "%-47b%b" "$(GREEN)PROJECT:$(DEF_COLOR)" "$(PROJECT_NAME)\n";
						@printf "%-47b%b" "$(GREEN)VERSION:$(DEF_COLOR)" "$(VERSION)\n";
						@printf "%-47b%b" "$(GREEN)BUILD:$(DEF_COLOR)" "$(BUILD_DATE)\n";
endef

define DISPLAY_HELP
						$(call SEPARATOR)
						@printf "                              MAKEFILE HELP\n"
						$(call SEPARATOR)
						@printf "$(GREEN)Basic commands:$(DEF_COLOR)\n"
						@printf "%-33b%b" "make" "- Build in release mode\n"
						@printf "%-33b%b" "make clean" "- Remove object files\n"
						@printf "%-33b%b" "make fclean" "- Remove all generated files\n"
						@printf "%-33b%b" "make re" "- Clean and rebuild\n\n"
						@printf "$(GREEN)Advanced commands:$(DEF_COLOR)\n"
						@printf "%-33b%b" "make info" "- Show system info\n"
						$(call SEPARATOR)
endef

define DISPLAY_INFO
						$(call SEPARATOR)
						@printf "                              MAKEFILE INFO\n"
						$(call SEPARATOR)
						@printf "%-39b%b" "$(GREEN)🖥️ Système:$(DEF_COLOR)" "$(UNAME_S)\n"
						@printf "%-35b%b" "$(GREEN)🔧 CPU Cores:$(DEF_COLOR)" "$(NPROCS)\n"
						@printf "%-35b%b" "$(GREEN)🐳 Docker:$(DEF_COLOR)" "$$(docker --version 2>/dev/null || echo 'Non installé')\n"
						@printf "%-36b%b" "$(GREEN)📁 Répertoire:$(DEF_COLOR)" "$$(pwd)\n"
						@printf "%-35b%b" "$(GREEN)📋 Compose Files:$(DEF_COLOR)" "\n"
						@printf "%-20b%b" "• Principal:" "$(COMPOSE_F)\n"
						$(call SEPARATOR)
endef

define TITLE
	@printf "\n$(CYAN)▶ $(1)$(DEF_COLOR)\n"
endef

define SUCCESS
	@printf "$(GREEN)✅ $(1)$(DEF_COLOR)\n\n"
endef

define WARNING
	@printf "$(YELLOW)⚠️  $(1)$(DEF_COLOR)\n"
endef

define ERROR
	@printf "$(RED)❌ $(1)$(DEF_COLOR)\n"
endef
