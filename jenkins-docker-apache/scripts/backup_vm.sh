#!/bin/bash

hosts="data/ip.txt"
priv_key="data/id_rsa"
script="scripts/vm/backup.sh"

while IFS= read -r ip_address
do
    scp -i "$priv_key" "$script" "vagrant@$ip_address:/tmp"
    ssh -i "$priv_key" -n "vagrant@$ip_address" "/tmp/backup.sh" < /dev/null
done < "$hosts"
