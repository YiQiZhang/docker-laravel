WEBSERVER_DIR_NAME="nginx"
WEBSERVER_REPOSITORY_ADDR="git@github.com:YiQiZhang/docker-laravel-nginx.git"
NGINX_VERSION="nginx-1.9.10"
WEBSERVER_IMAGE="jerrytechtree/docker-laravel-nginx"
WEBSERVER_DOCKER_CONTAINER="webserver"
WEBSERVER_LISTEN_PORT="80"
APPLICATION_DIR="platform"

all: system application

system: webserver php7 db cache

webserver:
	./webserver.sh $(WEBSERVER_DIR_NAME) $(WEBSERVER_REPOSITORY_ADDR) $(NGINX_VERSION) $(WEBSERVER_IMAGE) $(WEBSERVER_DOCKER_CONTAINER) $(WEBSERVER_LISTEN_PORT) $(APPLICATION_DIR)	

php7:
	echo 'php7'

db:
	echo 'mysql'

cache:
	echo 'redis'

application:
	mkdir -p ./$(APPLICATION_DIR)

clean:
	rm -rf $(WEBSERVER_DIR_NAME) $(APPLICATION_DIR)

.PHONY: clean webserver php7 db cache system application
