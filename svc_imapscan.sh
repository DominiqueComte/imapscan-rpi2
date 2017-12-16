#! /bin/sh

IMAGE_VERSION=0.17
CONTAINER_VOLUMES_DIR=/opt/imapscan

sudo mkdir -p ${CONTAINER_VOLUMES_DIR}/spamassassin \
              ${CONTAINER_VOLUMES_DIR}/accounts \
              ${CONTAINER_VOLUMES_DIR}/imapfilter

docker service create --name imapscan \
  --mount type=bind,src=${CONTAINER_VOLUMES_DIR}/accounts,dst=/root/accounts \
  --mount type=bind,src=${CONTAINER_VOLUMES_DIR}/imapfilter,dst=/root/.imapfilter \
  --mount type=bind,src=${CONTAINER_VOLUMES_DIR}/spamassassin,dst=/var/spamassassin \
  domcomte/imapscan-rpi2:${IMAGE_VERSION}
