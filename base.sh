#!/bin/sh

DIR_NAME=$1
REPOSITORY_ADDR=$2
DOCKER_IMAGE=$3

./updateRepository.sh ${DIR_NAME} ${REPOSITORY_ADDR}

cd ${DIR_NAME}
git clone ${APP_REPOSITORY_ADDR} base
sudo docker build -t ${DOCKER_IMAGE} .

