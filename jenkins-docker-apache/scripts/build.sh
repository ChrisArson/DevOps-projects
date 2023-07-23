#!/bin/bash

#Create/recreate containers with alpine and apache2 web server
docker compose -f $PWD/jenkins-docker-apache/web/docker-compose-alpine.yaml up -d --force-recreate

#Copy files downloaded from alpine container to host
docker cp alpine-web:/mnt/webfiles/data data/

rm -rf data/webfiles
mv data/data data/webfiles
