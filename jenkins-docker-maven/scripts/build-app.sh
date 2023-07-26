#!/bin/bash

docker run --rm -v $PWD/jenkins-docker-maven/app:/app -v /root/.m2/:/root/.m2/ -w /app maven:3.8.6-eclipse-temurin-11-alpine mvn -B -DskipTests clean package

cp -r $PWD/app/target/*.jar $PWD/data

