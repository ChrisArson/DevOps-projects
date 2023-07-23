# DevOps-projects
This repository contains some of the projects I've been preparing while learning DevOps skills and tools

---

## 1. Jenkins Apache Docker
### Introduction
Project directory: jenkins-apache-docker/

This project provides a practical example of using Jenkins to automate the build and deployment of an Apache web server within a Docker container. In final result scripts will download, extract and deploy webfiles data to two virtual machines and one container with apache2 server. It is built on the contenaraized Jenkins image with Docker installed on it. The Jenkins data dir is attached to the host volume, but its outside the version control.

### Directory structure
---

----
1. data/

Folder that contains file with ip adresses of machines with apache2 and RSA key which is outside version control. There is also stored downloaded website files which are used on vms and container with apache2 server.

2. web/

Folder that contains Dockerfile and docker-compose file. Dockerfile is based on alpine:latest image and it's only purpouse is to download the newest website data files using RSA key from private repository on github and extract it. Docker compose file contains configuration to build alpine container from Dockerfile and container with apache2 server.

3. scripts/

This folder contains all the scripts, that are used in this project.

build.sh - it is creating/recreating containers with alpine and apache2 server. It also copying web files from exited alpine container to the host machine.

deploy.sh - using file with ip addresses it is copying initialization script and web files from host machine to the virtual machines.

vm/init.sh - script that is running after deploy on virtual machines. It checks if apache2 server is installed, then if apache2 service is running. It also extract and move web files to the desired directories.

vm/backup.sh - script used to create backup of web files and logs from apache2 server before every deploy. It is checking the amount of backups and if the limit is reached it deleted the oldest backup.

