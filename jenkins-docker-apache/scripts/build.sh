#!/bin/bash
docker compose -f $PWD/jenkins-docker-apache/web/docker-compose-alpine.yaml up -d --force-recreate
docker cp alpine-web:/mnt/webfiles/data data/
rm -rf $PWD/jenkins-docker-apache/data/webfiles
mv $PWD/jenkins-docker-apache/data/data $PWD/jenkins-docker-apache/data/webfiles
