# This Makefile is designed to be included by another Makefile located in your project directory.
# ==> https://github.com/EmakinaFR/docker-magento2/wiki/Makefile

PHP_SERVICE := docker-compose exec php sh -c

# Define a static project name that will be prepended to each service name
export COMPOSE_PROJECT_NAME := $(shell grep COMPOSE_PROJECT_NAME ${DOCKER_PATH}/docker.env | awk -F '=' '{print $$NF}')

# Extract environment variables needed by the environment
export PROJECT_LOCATION := $(shell echo ${MAKEFILE_DIRECTORY})

# Extract path to the magento directory
export MAGENTO_ROOT := $(shell echo ${MAKEFILE_DIRECTORY})$(shell grep MAGENTO_ROOT ${DOCKER_PATH}/docker.env | awk -F '=' '{print $$NF}')

# Extract php version variable
export PHP_VERSION := $(shell grep PHP_VERSION ${DOCKER_PATH}/docker.env | awk -F '=' '{print $$NF}')

# Extract magneto version variable
export MAGENTO_VERSION := $(shell grep MAGENTO_VERSION ${DOCKER_PATH}/docker.env | awk -F '=' '{print $$NF}')

##
## ----------------------------------------------------------------------------
##   Environment
## ----------------------------------------------------------------------------
##

backup: ## Backup the "mysql" volume
	docker run --rm \
		--volumes-from $$(docker-compose ps -q mysql) \
		-v $$(pwd):/backup \
		busybox sh -c "tar cvf /backup/backup.tar /var/lib/mysql"

build: ## Build the environment
	docker-compose build

cache: ## Flush cache stored in Redis
	docker-compose exec redis sh -c "redis-cli flushall"

logs: ## Follow logs generated by all containers
	docker-compose logs -f --tail=0

logs-full: ## Follow logs generated by all containers from the containers creation
	docker-compose logs -f

nginx: ## Open a terminal in the "nginx" container
	docker-compose exec nginx sh

user := www-data
php: ## Open a terminal in the "php" container
	docker-compose exec --user $(user) php sh

mysql: ## Open a terminal in the "mysql" container
	docker-compose exec --user root mysql sh

phpmyadmin: ## Open a terminal in the "phpmyadmin" container
	docker-compose exec --user root phpmyadmin sh

ps: ## List all containers managed by the environment
	docker-compose ps

restart: stop start ## Restart the environment

restore: ## Restore the "mysql" volume
	docker run --rm \
		--volumes-from $$(docker-compose ps -q mysql) \
		-v $$(pwd):/backup \
		busybox sh -c "tar xvf /backup/backup.tar var/lib/mysql/"
	docker-compose restart mysql
file := backup
db-dump: ## dump the mysql database [file=<file name>]
	docker-compose exec -T -u root mysql mysqldump -umagento -pmagento magento | gzip -c > $(DOCKER_PATH)/mysqldump/$(file).sql.gz

db-import: ## import to mysql database [file=<file name>]
	@zcat -f $(DOCKER_PATH)/mysqldump/$(file) | docker-compose  exec -u root mysql mysql -umagento -pmagento magento \
	&& docker-compose exec -T -u root mysql mysql -umagento -pmagento magento --execute="update core_config_data set value='https://www.magento.localhost' where path='web/unsecure/base_url';" \
    && docker-compose exec -T -u root mysql mysql -umagento -pmagento magento --execute="update core_config_data set value='https://www.magento.localhost' where path='web/secure/base_url';"


start: ## Start the environment
	docker-compose build
	docker-compose up -d --remove-orphans

stats: ## Print real-time statistics about containers ressources usage
	docker stats $(docker ps --format={{.Names}})

stop: ## Stop the environment
	docker-compose stop

kill: ## kill all the project's docker container
	docker-compose  stop \
	& docker-compose  down -v

yarn: ## Install Composer dependencies from the "php" container
	$(PHP_SERVICE) "yarn install --cwd=/var/www/html"

magento2-install: ## Installs new Magento 2 instance [version=<m2-version>]
	docker-compose exec --user www-data php composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition: $(version) .
	docker-compose exec --user www-data php bin/magento setup:install \
		--base-url=https://magento.localhost \
		--db-host=mysql \
		--db-name=magento \
		--db-user=magento \
		--db-password=magento \
		--backend-frontname=admin \
		--admin-firstname=admin \
		--admin-lastname=admin \
		--admin-email=admin@admin.com \
		--admin-user=admin \
		--admin-password=admin123 \
		--language=en_US \
		--currency=USD \
		--timezone=America/Chicago \
		--use-rewrites=1

n98: ## n98-magerun2 commands [t="<task>"]
	@docker-compose exec --user www-data php n98 $(t)

magento: ## magento commands [t="<task>"]
	@docker-compose exec --user www-data php bin/magento $(t)

composer: ## composer commands [t="<task>"]
	@docker-compose exec --user www-data php composer $(t)

static-cache: ## clear the Magento static cache
	@rm -rf src/pub/static/* \
	& rm -rf src/var/cache/* \
	& rm -rf src/var/composer_home/* \
	& rm -rf src/var/page_cache/* \
	& rm -rf src/var/view_preprocessed/* \
	& make n98 t=cache:flush

##
## ----------------------------------------------------------------------------
##   Links
## ----------------------------------------------------------------------------
##

Magento: ## https://www.magento.localhost 
	@xdg-open https://www.magento.localhost

Magento-admin: ## https://www.magento.localhost/admin user=admin password=admin123
	@xdg-open https://www.magento.localhost/admin

phpMyAdmin: ## http://www.magento.localhost:8080
	@xdg-open http://www.magento.localhost:8080

Maildev: ## http://www.magento.localhost:1080
	@xdg-open http://www.magento.localhost:1080

.PHONY: backup build cache composer logs logs-full nginx php ps restart restore start stats stop yarn magento2-install n98

.DEFAULT_GOAL := help
help:
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) \
		| sed -e 's/^.*Makefile://g' \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' \
		| sed -e 's/\[32m##/[33m/'
.PHONY: help
