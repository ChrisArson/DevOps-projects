#!/bin/bash

cp -r $PWD/jenkins-docker-maven/app/target/*.jar $PWD/jenkins-docker-maven/data

docker compose -f $PWD/jenkins-docker-maven/data/docker-compose-java.yaml up -d --force-recreate
