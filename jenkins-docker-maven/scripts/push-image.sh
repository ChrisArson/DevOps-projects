#!/bin/bash
docker tag jenkins-docker-maven:latest chrisarson/jdm-project:"$1"
echo "$3" | docker login -u "$2" --password-stdin
docker push chrisarson/jdm-project:"$1"
