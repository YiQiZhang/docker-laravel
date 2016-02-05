#!/bin/sh

DIR_NAME=$1
REPOSITORY_ADDR=$2
DOCKER_IMAGE=$3
DOCKER_CONTAINER=$4
HOST_PORT=$5
LOG_PATH=$6
APP_CONTAINER=$7
PHP_CONTAINER=$8

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
