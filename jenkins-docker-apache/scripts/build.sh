#!/bin/bash
docker compose -f $PWD/jenkins-docker-apache/web/docker-compose-alpine.yaml up -d --force-recreate
docker cp alpine-web:/mnt/webfiles/data data/
rm -rf data/webfiles
mv data/data data/webfiles
