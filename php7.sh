#!/bin/sh

DIR_NAME=$1
REPOSITORY_ADDR=$2
DOCKER_IMAGE=$3
DOCKER_CONTAINER=$4
PHP_VERSION=$5
LOG_PATH=$6
APP_CONTAINER=$7
DB_CONTAINER=$8
CACHE_CONTAINER=$9
PHP_TAR_NAME="${PHP_VERSION}.tar.gz"
PHP_TAR_DIR="${DIR_NAME}/software"
PHP_TAR_FILE="${PHP_TAR_DIR}/${PHP_TAR_NAME}"
PHP_TAR_FINAL_FILE="${PHP_TAR_DIR}/php.tar.gz"
DOWNLOAD_URL="http://cn2.php.net/get/${PHP_TAR_NAME}/from/this/mirror"

./updateRepository.sh ${DIR_NAME} ${REPOSITORY_ADDR}

if [ ! -d ${PHP_TAR_DIR} ]; then
  mkdir -p $PWD/${PHP_TAR_DIR}
fi

if [ ! -f ${PHP_TAR_FINAL_FILE} ]; then
  wget ${DOWNLOAD_URL} -O ${PHP_TAR_FINAL_FILE}
fi 

if [ ! -d ${LOG_PATH} ]; then
  sudo mkdir -p ${LOG_PATH}
fi

cd ${DIR_NAME}
sudo docker build -t ${DOCKER_IMAGE} .
sudo docker stop ${DOCKER_CONTAINER}
sudo docker rm ${DOCKER_CONTAINER}
sudo docker run -ti --name ${DOCKER_CONTAINER} \
	--link ${DB_CONTAINER} \
	--link ${CACHE_CONTAINER} \
	--volumes-from ${APP_CONTAINER} \
	-v ${LOG_PATH}:/var/log/php \
	${DOCKER_IMAGE}
