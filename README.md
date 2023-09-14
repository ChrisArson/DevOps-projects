# DevOps-projects
This repository contains some of the projects I've been preparing while learning/training DevOps skills and tools

## Table of Contents
* [1. Jenkins Apache Docker](#jda)
	* [1.1 Introduction](#jda-intro)
	* [1.2 Directory structure](#jda-dir)
	* [1.3 Flow of execution](#jda-flow)
* [2. Jenkins Apache Maven](#jdm)
	* [2.1 Introduction](#jdm-intro)
	* [2.2 Directory structure](#jdm-dir)
	* [2.3 Flow of execution](#jdm-flow)
* [3. Ansible](#ans)
	* [3.1 Introduction](#ans-intro)
	* [3.2 Directory structure](#ans-dir)
	* [3.3 Flow of execution](#ans-flow)
* [4. Terraform Kubernetes](#terra)
	* [4.1 Introduction](#terra-intro)
	* [4.2 Directory structure](#terra)
	* [4.3 Flow of execution](#terra) 

---
<a name="jda"></a>
## 1. Jenkins Docker Apache
<a name="jda-intro"></a>
### 1.1 Introduction

Project directory: `jenkins-docker-apache/`

This project provides a practical example of using Jenkins to automate the build and deployment of an Apache web server within a Docker container. In final result scripts will download, extract and deploy webfiles data to two virtual machines and one container with apache2 server. It is built on the contenaraized Jenkins image with Docker installed on it. The Jenkins data dir is attached to the host volume for backup purpose, but its outside the version control.

---
<a name="jda-dir"></a>
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
<a name="jdm"></a>
## 2. Jenkins Apache Maven
<a name="jdm-intro"></a>
### 2.1 Introduction

Project directory: `jenkins-docker-maven/`

This project provides a practical example of using Jenkins to automate the tests, build and deployment of image with java application within a Docker container. As a result there will be image on [dockerhub](https://hub.docker.com/r/chrisarson/jdm-project) with tested and built java application. Java application that I used in this project comes from https://github.com/jenkins-docs/simple-java-maven-app. 

Project is built on the contenaraized Jenkins image with Docker installed on it. The Jenkins data dir is attached to the host volume for backup purpose, but its outside the version control.


---

<a name="jdm-dir"></a>
### 2.2 Directory structure

- `jenkins-docker-maven/`

Main directory that contains all subdirectories, docker/docker-compose and Jenkins pipeline files. In Dockerfile-Jenkins there are instructions to install docker and docker compose on jenkins/jenkins image. Docker compose file contains configuration to build container with Jenkins based on Dockerfile.

- `jenkins-docker-maven/data/`

Folder containing Dockerfile and docker compose used in building an image with Java Runtime Environment.

- `jenkins-docker-maven/app/`

Directory that contains java app files

- `jenkins-docker-maven/scripts`

This folder contains all the scripts, that are used in this project. All of them are described in [2.3 Flow of execution](#jdm-flow) section.

---

<a name="jdm-flow"></a>
### 2.3 Flow of execution

- Stage "App pull"

The `pull-app.sh` script clones the repository with java app and copies `pom.xml` and `src/` to `app/`. After that dir with repo is deleting.

- Stage "Test"

Application is tested with `maven.sh`. This script is creating a docker container with maven image on it and it runs the given command, in this case is `mvn clean` and `mvn test`. Dircetory with files pulled before is mounted to the container. In post section, JUnit collects and displays the test results after completed `Test` stage.

- Stage "App build"

Using the same `maven.sh` script the application is building and after that artifact is copied to `data/` dir for image building purpose. In the successful post section Jenkins is achiving the artefact. Also using S3 publisher plugin the artefact is copied to S3 Bucket.

- Stage "Image Build"

Using docker compose an image based on `Dockerfile-Java` is created. The image is creating and copying built artifact.

- Stage "Image Push"

Script `push-image.sh` changes the default tag to number of build that comes from environment variable in Jenkins. After that using credentials, machine is logging in docker account and in result the image with application on it is pushed to [Docker hub](https://hub.docker.com/r/chrisarson/jdm-project)

- Stage "Deploy"

Deployment is done by using plugin SSH Agent. Script `vm/init.sh` is copied and executed through ssh. The script pulls and runs the container with the latest image from docker hub.

---
<a name="ans"></a>
## 3. Ansible
<a name="ans-intro"></a>
### 3.1 Introduction

Project directory: `ansible/`

This projects provides practical example of using Ansible to prepare an Apache server with the latest web files on remote machines. It also automate the tests, build and deployment of image with java application within Docker container. In first part playbook will download extract and deploy webfiles data to two virtual machines with different Linux distribution. The second part of playbook is automation around java application. As a result there will be an image on [dockerhub](https://hub.docker.com/r/chrisarson/ans-project) with tested and built java application. Image is going to be pulled and run on remote virtual machine. Java application that I used in this project comes from https://github.com/jenkins-docs/simple-java-maven-app. 

---

<a name="ans-dir"></a>
### 3.2 Directory structure

- `ansible/`

Main directory that contains all subdirectories, main playbook, ansible vault with aws credentials and configuration.

- `ansible/invetories`

Folder that contains inventory files.

- `ansible/logs`

Directory with ansible logs.

- `ansible/roles`

Folder with ansible roles. All of them are described in [3.3 Flow of execution](#ans-flow) section.


---

<a name="ans-flow"></a>
### 3.3 Flow of execution

- Role "web_role"

First step is installing necessary tools depending on Linux distribution and checking is the web server service currently running, if not the handlers will start them. After that instructions copies RSA key with proper permissions to get access to private repository on github to download webfiles that web server are going to use.

- Role "docker_install"

Instructions are installing and configuring Docker Engine on local machine.

- Role "image_build"

First, the [github repository](https://github.com/jenkins-docs/simple-java-maven-app) with simple java application is downloaded. The application is tested and with successful tests it is built. After that with ready application, the Docker image is built using Dockerfile in `files` directory. The last step is to upload artifact to S3 Bucket. The credentials to IAM Role are stored in ansible vault. To later add a proper version of the Docker image on an external machine, the last tag of the image is stored in the `image_version.txt` file.

- Role "app_deploy"

Instructions set the variable with latest image tag, pull the image and run it with Docker container on remote virtual machine.


---
<a name="terra"></a>
## 4. Terraform Kubernetes
<a name="terra-intro"></a>
### 4.1 Introduction

Project directory: `terraform-kubernetes/`

Work in progess..
