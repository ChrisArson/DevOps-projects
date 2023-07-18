#!/bin/bash

hosts="data/ip.txt"
priv_key="data/id_rsa"
script="scripts/vm/init.sh"
webfiles="data/webfiles.tar.gz"

tar -czvf "$webfiles" data/webfiles

while IFS= read -r ip_address
do
    scp -i "$priv_key" "$script" "vagrant@$ip_address:/tmp"
    scp -i "$priv_key" "$webfiles" "vagrant@$ip_address:/tmp"
    ssh -i "$priv_key" -n "vagrant@$ip_address" "/tmp/init.sh" < /dev/null
    #ssh -o BatchMode=yes -i "$priv_key" "vagrant@$ip_address" "/tmp/init.sh"
done < "$hosts"
