#!/bin/bash
echo "$3" | docker login -u "$2" --password-stdin
docker pull chrisarson/jdm-project:"$1"
docker run -d chrisarson/jdm-project:"$1"