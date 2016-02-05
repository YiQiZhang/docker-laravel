#!/bin/sh

DIR_NAME=$1
REPOSITORY_ADDR=$2
DOCKER_IMAGE=$3
DOCKER_CONTAINER=$4
HOST_PORT=$6
LOG_PATH=$7
APP_CONTAINER=$8
PHP_CONTAINER=$9

./updateRepository.sh ${DIR_NAME} ${REPOSITORY_ADDR}

if [ ! -d ${LOG_PATH} ]; then
  sudo mkdir -p ${LOG_PATH}
fi

cd ${DIR_NAME}
sudo docker build -t ${DOCKER_IMAGE} .
sudo docker stop ${DOCKER_CONTAINER}
sudo docker rm ${DOCKER_CONTAINER}
sudo docker run -d -p ${HOST_PORT}:80 --name ${DOCKER_CONTAINER} \
	--link ${PHP_CONTAINER}:phpfpm \
	--volumes-from ${APP_CONTAINER} \
	-v ${LOG_PATH}:/var/log/nginx \
	${DOCKER_IMAGE} 
