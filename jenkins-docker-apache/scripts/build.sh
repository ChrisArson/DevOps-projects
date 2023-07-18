#!/bin/bash
docker compose -f web/docker-compose-alpine.yaml up -d --force-recreate
docker cp alpine-web:/mnt/webfiles/data data/
sudo rm -rf data/webfiles
sudo mv data/data data/webfiles
