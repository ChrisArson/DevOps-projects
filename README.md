# DevOps-projects
This repository contains some of the projects I've been preparing while learning/training DevOps skills and tools

---

## 1. Jenkins Apache Docker
### 1.1 Introduction

Project directory: `jenkins-apache-docker/`

This project provides a practical example of using Jenkins to automate the build and deployment of an Apache web server within a Docker container. In final result scripts will download, extract and deploy webfiles data to two virtual machines and one container with apache2 server. It is built on the contenaraized Jenkins image with Docker installed on it. The Jenkins data dir is attached to the host volume for backup purpose, but its outside the version control.

---
### 1.2 Directory structure

1. data/

Folder that contains file with ip adresses of machines with apache2 and RSA key which is outside version control. There are also stored downloaded website files which are used on vms and container with apache2 server.

2. web/

Folder that contains Dockerfile and docker-compose file. Dockerfile is based on alpine:latest image and it's only purpouse is to download the newest website data files using RSA key from private repository on github and extract it. Docker compose file contains configuration to build alpine container from Dockerfile and container with apache2 server.

3. scripts/

This folder contains all the scripts, that are used in this project:

build.sh - it is creating/recreating containers with alpine and apache2 server. It also copying web files from exited alpine container to the host machine,

backup_vm.sh && deploy_vm.sh - using file with ip addresses it is copying backup/initialization script and web files from host machine to vms and runs the scripts on them,

vm/init.sh - script that is running after deploy on virtual machines. It checks if apache2 server is installed, then if apache2 service is running. It also extract and move web files to the desired directories,

vm/backup.sh - script used to create backup of web files and logs from apache2 server before every deploy. It is checking the amount of backups and if the limit is reached it deleted the oldest backup.

---

## 2. Jenkins Apache Maven
### 2.1 Introduction

Java application that I used in this project comes from `https://github.com/jenkins-docs/simple-java-maven-app`

Project directory: `jenkins-docker-maven/`

### 2.2 Directory structure


### 2.3 Flow of execution

[Docker hub](https://hub.docker.com/repository/docker/chrisarson/jdm-project/general)

