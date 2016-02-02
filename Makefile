WEBSERVER_DIR_NAME="nginx"
WEBSERVER_REPOSITORY_ADDR="git@github.com:YiQiZhang/docker-laravel-nginx.git"

all: webserver php7 db cache

webserver:
	./webserver.sh $(WEBSERVER_DIR_NAME) $(WEBSERVER_REPOSITORY_ADDR)	

php7:
	echo 'php7'

db:
	echo 'mysql'

cache:
	echo 'redis'

clean:
	echo 'clean'

.PHONY: clean webserver php7 db cache
