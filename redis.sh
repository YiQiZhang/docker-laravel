#!/bin/sh

DIR_NAME=$1
REPOSITORY_ADDR=$2
DOCKER_IMAGE=$3
DOCKER_CONTAINER=$4
PERSISTENT_STORAGE=$5

./updateRepository.sh ${DIR_NAME} ${REPOSITORY_ADDR}

cd ${DIR_NAME}
sudo docker build -t ${DOCKER_IMAGE} .
sudo docker stop ${DOCKER_CONTAINER}
sudo docker rm ${DOCKER_CONTAINER}
sudo docker run -d --name ${DOCKER_CONTAINER} \
	-v ${PERSISTENT_STORAGE}:/data \
	${DOCKER_IMAGE} redis-server --appendonly yes
