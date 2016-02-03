#!/bin/sh

DIR_NAME=$1
REPOSITORY_ADDR=$2
DOCKER_IMAGE=$3
DOCKER_CONTAINER=$4
APP_REPOSITORY_ADDR=$5

./updateRepository.sh ${DIR_NAME} ${REPOSITORY_ADDR}

cd ${DIR_NAME}
git clone ${APP_REPOSITORY_ADDR} app
sudo docker build -t ${DOCKER_IMAGE} .
sudo docker stop ${DOCKER_CONTAINER}
sudo docker rm ${DOCKER_CONTAINER}
sudo docker run -d --name ${DOCKER_CONTAINER} \
	-v app:/data/www \
	${DOCKER_IMAGE} 
