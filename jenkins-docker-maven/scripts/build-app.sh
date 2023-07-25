#!/bin/bash

docker run --rm -v /home/vagrant/projects/jenkins-docker-maven/simple-java-maven-app:/app -v /root/.m2/:/root/.m2/ -w /app maven:3.8.6-eclipse-temurin-11-alpine mvn -B -DskipTests clean package

cp -r app/target/*.jar data

