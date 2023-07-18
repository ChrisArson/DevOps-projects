#!/bin/bash

hosts="$PWD/jenkins-docker-apache/data/ip.txt"
priv_key="$PWD/jenkins-docker-apache/data/id_rsa"
script="$PWD/jenkins-docker-apache/scripts/vm/backup.sh"

chmod 600 "$priv_key"

while IFS= read -r ip_address
do
    scp -i "$priv_key" "$script" "vagrant@$ip_address:/tmp"
    ssh -i "$priv_key" -n "vagrant@$ip_address" "/tmp/backup.sh" < /dev/null
done < "$hosts"
