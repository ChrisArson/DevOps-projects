#!/bin/bash
PATH=/home/vagrant/projects/jenkins-docker-maven/jenkins_backup_data/jenkins_home/workspace/jenkins-docker-maven/jenkins-docker-maven
git clone https://github.com/jenkins-docs/simple-java-maven-app.git $PATH
mkdir -p $PATH/app
cp -r $PATH/simple-java-maven-app/jenkins $PATH/simple-java-maven-app/pom.xml $PATH/simple-java-maven-app/src $PATH/app 
#rm -rf simple-java-maven-app
