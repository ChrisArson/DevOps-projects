# DevOps-projects
This repository contains some of the projects I've been preparing while learning/training DevOps skills and tools

## Table of Contents
- [1. Jenkins Apache Docker](#jda)
- [1.1 Introduction](#jda-introduction)
- [1.2 Directory structure](#jda-dir-str)
- [1.3 Flow of execution](#jda-flow)

---
<a name="jda"></a>
## 1. Jenkins Docker Apache
<a name="jda-introduction"></a>
### 1.1 Introduction

Project directory: `jenkins-docker-apache/`

This project provides a practical example of using Jenkins to automate the build and deployment of an Apache web server within a Docker container. In final result scripts will download, extract and deploy webfiles data to two virtual machines and one container with apache2 server. It is built on the contenaraized Jenkins image with Docker installed on it. The Jenkins data dir is attached to the host volume for backup purpose, but its outside the version control.

---
<a name="jda-dir-str"></a>
### 1.2 Directory structure

- `jenkins-docker-apache/`

Main directory that contains all subdirectories, docker/docker-compose and Jenkins pipeline files. In Dockerfile-Jenkins there are instructions to install docker and docker compose on jenkins/jenkins image. Docker compose file contains configuration to build container with Jenkins based on Dockerfile.

- `jenkins-docker-apache/data/`

Folder that contains file with ip adresses of machines with apache2 and RSA key which is outside version control. There are also stored downloaded website files which are used on vms and container with apache2 server.

- `jenkins-docker-apache/web/`

Folder that contains Dockerfile and docker-compose file. Dockerfile is based on alpine:latest image and it's only purpouse is to download the newest website data files using RSA key from private repository on github and extract it. Docker compose file contains configuration to build alpine container from Dockerfile and container with apache2 server.

- `jenkins-docker-apache/scripts/`

This folder contains all the scripts, that are used in this project. All of them are described in [1.3 Flow of execution](#jda-flow) section.

---


<a name="jda-flow"></a>
### 1.3 Flow of execution

- Stage "Build"

In first step script `build.sh` create and starts two containers, alpine with instructions from Dockerfile-Alpine and Apache2 container which will be web server. Dockefile-Alpine instructions is installing necessary tools, copying RSA key from host machine to get access to private repository on github, downloading and extracting downloaded web files. After that, the alpine container will exited and script is copying downloaded web files from exited container to directory in host machine that is mounted to Apache2 web server.

- Stage "Backup"

Script `backup_vm.sh` copies and executes `vm/backup.sh` script throught ssh on two virtual machines. Ip adresses of machines are stored in `data/ip.txt`. The copied script `vm/backup.sh` checks for previous webfiles and logs. If they exist, its making backup of them and also checks that if there are more than maximum number of backups it deletes the last one.

- Stage "Deploy"

Script `deploy_vm.sh` copies and executes `vm/init.sh` on virtual machines using the same ip adresses as in Backup stage. Additionaly its also copies prepared before new web files. Script `init.sh` at first is checks if the Apache2 web server is installed, if not it installing it. After that script moves webfiles to the desired location and checks the status of Apache2 service, if the service is not running its make process start.

---

## 2. Jenkins Apache Maven
### 2.1 Introduction

This project provides a practical example of using Jenkins to automate the build and deployment of an Apache web server within a Docker container. In final result scripts will download, extract and deploy webfiles data to two virtual machines and one container with apache2 server. It is built on the contenaraized Jenkins image with Docker installed on it. The Jenkins data dir is attached to the host volume for backup purpose, but its outside the version control.



Java application that I used in this project comes from `https://github.com/jenkins-docs/simple-java-maven-app`

Project directory: `jenkins-docker-maven/`

### 2.2 Directory structure

- `jenkinds-docker-maven/

- `jenkinds-docker-maven/data/`

- `jenkinds-docker-maven/scripts`

### 2.3 Flow of execution

[Docker hub](https://hub.docker.com/repository/docker/chrisarson/jdm-project/general)

