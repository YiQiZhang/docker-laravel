#!/bin/sh

DIR_NAME=$1
REPOSITORY_ADDR=$2
NGINX_VERSION=$3
DOCKER_IMAGE=$4
DOCKER_CONTAINER=$5
HOST_PORT=$6
LOG_PATH=$7
NGINX_TAR_NAME="${NGINX_VERSION}.tar.gz"
NGINX_TAR_DIR="${DIR_NAME}/software"
NGINX_TAR_FILE="${NGINX_TAR_DIR}/${NGINX_TAR_NAME}"
NGINX_TAR_FINAL_FILE="${NGINX_TAR_DIR}/nginx.tar.gz"
DOWNLOAD_URL="http://nginx.org/download/${NGINX_TAR_NAME}"

./updateRepository.sh ${DIR_NAME} ${REPOSITORY_ADDR}
if [ ! -f ${NGINX_TAR_FINAL_FILE} ]; then
  wget -P ${NGINX_TAR_DIR} ${DOWNLOAD_URL}
  mv ${NGINX_TAR_FILE} ${NGINX_TAR_FINAL_FILE}
fi 

if [ ! -d ${LOG_PATH} ]; then
  mkdir -p ${LOG_PATH}
fi

cd ${DIR_NAME}
sudo docker build -t ${DOCKER_IMAGE} .
sudo docker stop ${DOCKER_CONTAINER}
sudo docker rm ${DOCKER_CONTAINER}
sudo docker run -d -p ${HOST_PORT}:80 --name ${DOCKER_CONTAINER} \
	-v ${LOG_PATH}:/var/log/nginx \
	${DOCKER_IMAGE} 
