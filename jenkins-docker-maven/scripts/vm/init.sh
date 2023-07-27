#!/bin/bash
docker pull chrisarson/jdm-project:"$1"
docker run -d chrisarson/jdm-project:"$1"
