#!/bin/bash

docker run --rm -v /home/vagrant/projects/jenkins-docker-maven/jenkins_backup_data/jenkins_home/workspace/jenkins-docker-maven/jenkins-docker-maven/app:/app -v /root/.m2/:/root/.m2/ -w /app maven:3.8.6-eclipse-temurin-11-alpine mvn -B -DskipTests clean package

chown -r 1000:1000 $PWD/jenkins-docker-maven/app/target
cp -r $PWD/jenkins-docker-maven/app/target/*.jar $PWD/jenkins-docker-maven/data

