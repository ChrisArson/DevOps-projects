#!/bin/bash

hosts="$PWD/jenkins-docker-apache/data/ip.txt"
priv_key="$PWD/jenkins-docker-apache/data/id_rsa"
script="$PWD/jenkins-docker-apache/scripts/vm/init.sh"
webfiles="$PWD/jenkins-docker-apache/data/webfiles.tar.gz"

#Compress webfiles
tar -czvf "$webfiles" data/webfiles

#Copy script, webfiles and execute script on VMs
while IFS= read -r ip_address
do
    scp -i "$priv_key" "$script" "vagrant@$ip_address:/tmp"
    scp -i "$priv_key" "$webfiles" "vagrant@$ip_address:/tmp"
    ssh -i "$priv_key" -n "vagrant@$ip_address" "/tmp/init.sh" < /dev/null
done < "$hosts"
