#!/bin/bash
source ./subids.sh
RPS=("Microsoft.KeyVault" "Microsoft.ContainerInstance" "Microsoft.DBforPostgreSQL")

for s in "${SUBIDS[@]}"; do
    for rp in "${RPS[@]}"; do
        echo "Registering $rp in $s"
        az provider register --subscription ${s} --namespace ${rp}
    done
done


