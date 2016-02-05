BASE_DIR_NAME="base"
BASE_DOCKER_ADDR="git@github.com:YiQiZhang/docker-laravel-base.git"
BASE_IMAGE="jerrytechtree/docker-laravel-base"

APP_DIR_NAME="app"
APP_DOCKER_ADDR="git@github.com:YiQiZhang/docker-laravel-app.git"
APP_IMAGE="jerrytechtree/docker-laravel-app"
APP_CONTAINER="appfile"
APP_REPOSITORY_ADDR="git@github.com:YiQiZhang/docker-laravel-test-app.git"

WEBSERVER_DIR_NAME="nginx"
WEBSERVER_DOCKER_ADDR="git@github.com:YiQiZhang/docker-laravel-nginx.git"
NGINX_VERSION="nginx-1.9.10"
WEBSERVER_IMAGE="jerrytechtree/docker-laravel-nginx"
WEBSERVER_CONTAINER="webserver"
WEBSERVER_LISTEN_PORT="8888"
WEBSERVER_LOG_DIR="/data/log/nginx"

PHP_DIR_NAME="php7"
PHP_DOCKER_ADDR="git@github.com:YiQiZhang/docker-laravel-php7.git"
PHP_IMAGE="jerrytechtree/docker-laravel-php7"
PHP_CONTAINER="php7"
PHP_VERSION="php-7.0.2"
PHP_LOG_PATH="/data/log/php"

MYSQL_DIR_NAME="mysql"
MYSQL_DOCKER_ADDR="git@github.com:YiQiZhang/docker-laravel-mysql.git"
MYSQL_IMAGE="jerrytechtree/docker-laravel-mysql"
MYSQL_CONTAINER="db"
MYSQL_DATA_PATH="/data/mysql"
MYSQL_LOG_PATH="/data/log/mysql"
MYSQL_ROOT_PASSWORD="secret"
MYSQL_EXPOSE_PORT="33061"

REDIS_DIR_NAME="redis"
REDIS_DOCKER_ADDR="git@github.com:YiQiZhang/docker-laravel-redis.git"
REDIS_IMAGE="jerrytechtree/docker-laravel-redis"
REDIS_CONTAINER="cache"
REDIS_DATA_PATH="/data/redis"

all: application webserver

base:
	./base.sh $(BASE_DIR_NAME) $(BASE_DOCKER_ADDR) $(BASE_IMAGE)

application: base
	./application.sh $(APP_DIR_NAME) $(APP_DOCKER_ADDR) $(APP_IMAGE) $(APP_CONTAINER) $(APP_REPOSITORY_ADDR)

webserver: base php7
	./nginx.sh $(WEBSERVER_DIR_NAME) $(WEBSERVER_DOCKER_ADDR) $(NGINX_VERSION) $(WEBSERVER_IMAGE) $(WEBSERVER_CONTAINER) $(WEBSERVER_LISTEN_PORT) $(WEBSERVER_LOG_DIR) $(APP_CONTAINER)	$(PHP_CONTAINER)

php7: base db cache
	./php7.sh $(PHP_DIR_NAME) $(PHP_DOCKER_ADDR) $(PHP_IMAGE) $(PHP_CONTAINER) $(PHP_VERSION) $(PHP_LOG_PATH) $(APP_CONTAINER) $(MYSQL_CONTAINER) $(REDIS_CONTAINER)

db: base
	./mysql.sh $(MYSQL_DIR_NAME) $(MYSQL_DOCKER_ADDR) $(MYSQL_IMAGE) $(MYSQL_CONTAINER) $(MYSQL_DATA_PATH) $(MYSQL_LOG_PATH) $(MYSQL_ROOT_PASSWORD) $(MYSQL_EXPOSE_PORT)

cache:
	./redis.sh $(REDIS_DIR_NAME) $(REDIS_DOCKER_ADDR) $(REDIS_IMAGE) $(REDIS_CONTAINER) $(REDIS_DATA_PATH)

clean:
	rm -rf $(BASE_DIR_NAME) $(APP_DIR_NAME) $(WEBSERVER_DIR_NAME) $(PHP_DIR_NAME) $(MYSQL_DIR_NAME) $(REDIS_DIR_NAME)

.PHONY: clean base webserver php7 db cache system application
