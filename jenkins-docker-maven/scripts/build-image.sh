#!/bin/bash
docker compose -f $PWD/jenkins-docker-maven/data/docker-compose-java.yaml up -d --force-recreate
