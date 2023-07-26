#!/bin/bash
WORK_PATH="/home/vagrant/projects/jenkins-docker-maven/jenkins_backup_data/jenkins_home/workspace/jenkins-docker-maven"
git clone https://github.com/jenkins-docs/simple-java-maven-app.git "$WORK_PATH"
mkdir -p "$WORK_PATH/app"
cp -r "$WORK_PATH/simple-java-maven-app/jenkins" "$WORK_PATH/simple-java-maven-app/pom.xml" "$WORK_PATH/simple-java-maven-app/src" "$WORK_PATH/app" 
#rm -rf simple-java-maven-app
