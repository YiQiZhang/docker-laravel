#!/bin/sh

DIR_NAME=$1
REPOSITORY_ADDR=$2
DOCKER_IMAGE=$3
DOCKER_CONTAINER=$4
APP_REPOSITORY_ADDR=$5
APP_DIR_NAME="$1/app"

./updateRepository.sh ${DIR_NAME} ${REPOSITORY_ADDR}
./updateRepository.sh ${APP_DIR_NAME} ${APP_REPOSITORY_ADDR}

cd ${DIR_NAME}
sudo docker build -t ${DOCKER_IMAGE} .
sudo docker stop ${DOCKER_CONTAINER}
sudo docker rm ${DOCKER_CONTAINER}
sudo docker run -d --name ${DOCKER_CONTAINER} \
	-v $PWD/app:/data/www/ \
	${DOCKER_IMAGE} 
