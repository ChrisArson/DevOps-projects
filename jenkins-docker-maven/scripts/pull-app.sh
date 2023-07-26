#!/bin/bash
git clone https://github.com/jenkins-docs/simple-java-maven-app.git
cp -r simple-java-maven-app/jenkins simple-java-maven-app/pom.xml simple-java-maven-app/src app 
rm -rf simple-java-maven-app
