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
WEBSERVER_LISTEN_PORT="80"
WEBSERVER_LOG_DIR="/var/log/docker-laravel"

all: system

base:
	./base.sh $(BASE_DIR_NAME) $(BASE_DOCKER_ADDR) $(BASE_IMAGE)

application: base
	./application.sh $(APP_DIR_NAME) $(APP_DOCKER_ADDR) $(APP_IMAGE) $(APP_CONTAINER) $(APP_REPOSITORY_ADDR)

system: application webserver php7 db cache

webserver:
	./webserver.sh $(WEBSERVER_DIR_NAME) $(WEBSERVER_DOCKER_ADDR) $(NGINX_VERSION) $(WEBSERVER_IMAGE) $(WEBSERVER_CONTAINER) $(WEBSERVER_LISTEN_PORT) $(WEBSERVER_LOG_DIR) $(APP_CONTAINER)	

php7:
	echo 'php7'

db:
	echo 'mysql'

cache:
	echo 'redis'

clean:
	rm -rf $(BASE_DIR_NAME) $(APP_DIR_NAME) $(WEBSERVER_DIR_NAME) 

.PHONY: clean base webserver php7 db cache system application
