#!/bin/bash
hosts="$PWD/jenkins-docker-maven/data/ip.txt"
priv_key="$PWD/jenkins-docker-maven/data/id_rsa"
script="$PWD/jenkins-docker-maven/scripts/vm/init.sh"

chmod 600 "$priv_key"


#scp -i "$priv_key" "$script" "vagrant@192.168.77.20:/tmp"
ssh -v -i "$priv_key" "vagrant@192.168.77.20"
#Copy script, webfiles and execute script on VMs
#while IFS= read -r ip_address
#do
#    scp -i "$priv_key" "$script" "vagrant@$ip_address:/tmp"
#    ssh -i "$priv_key" -n "vagrant@$ip_address" "/tmp/init.sh $1 $2 $3" < /dev/null
#done < "$hosts"
