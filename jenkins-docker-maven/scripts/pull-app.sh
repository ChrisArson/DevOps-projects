#!/bin/bash
#WORK_PATH="/home/vagrant/projects/jenkins-docker-maven/jenkins_backup_data/jenkins_home/workspace/jenkins-docker-maven"
git clone https://github.com/jenkins-docs/simple-java-maven-app.git
mkdir -p "$PWD/jenkins-docker-maven/app"
cp -r "$PWD/simple-java-maven-app/jenkins" "$PWD/simple-java-maven-app/pom.xml" "$PWD/simple-java-maven-app/src" "$PWD/jenkins-docker-maven/app" 
#rm -rf simple-java-maven-app
