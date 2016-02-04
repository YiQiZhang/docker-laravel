#!/bin/sh

DIR_NAME=$1
REPOSITORY_ADDR=$2
DOCKER_IMAGE=$3
DOCKER_CONTAINER=$4
DATA_PATH=$5
LOG_PATH=$6
MYSQL_PASSWORD=$7

./updateRepository.sh ${DIR_NAME} ${REPOSITORY_ADDR}

if [ ! -d ${DATA_PATH} ]; then
  sudo mkdir -p ${DATA_PATH}
fi

if [ ! -d ${LOG_PATH} ]; then
  sudo mkdir -p ${LOG_PATH}
fi

cd ${DIR_NAME}
sudo docker build -t ${DOCKER_IMAGE} .
sudo docker stop ${DOCKER_CONTAINER}
sudo docker rm ${DOCKER_CONTAINER}
sudo docker run -d --name ${DOCKER_CONTAINER} \
	-v ${DATA_PATH}:/var/lib/mysql \
	-v $PWD/conf:/etc/mysql/conf.d \
	-v ${LOG_PATH}:/var/log/mysql \
	-e MYSQL_ROOT_PASSWORD=${MYSQL_PASSWORD} \
	${DOCKER_IMAGE} 
