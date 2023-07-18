#!/bin/bash
docker compose -f docker-compose-alpine.yaml up --force-recreate
docker cp alpine-web:/mnt/webfiles/data data/
mv data/data data/webfiles
