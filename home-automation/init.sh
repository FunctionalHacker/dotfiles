#!/bin/bash

sudo mkdir -p /homeautomation-config/node-red
sudo chmod -R a+rw /homeautomation-config/node-red

cat <<ENV > .env
MYSQL_ROOT_PASSWORD="$(pass reekynet/docker-home-automation | rg 'MYSQL_ROOT_PASSWORD' | cut -d' ' -f2-)"
HA_MYSQL_PASSWORD="$(pass reekynet/docker-home-automation | rg 'HA_MYSQL_PASSWORD' | cut -d' ' -f2-)"
DECONZ_VNC_PASSWORD="$(pass reekynet/docker-home-automation | rg 'DECONZ_VNC_PASSWORD' | cut -d' ' -f2-)"
ENV

docker-compose up
