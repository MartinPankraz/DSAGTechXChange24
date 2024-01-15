#!/usr/bin/bash
randpw(){ < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-16};echo;}

NUMBER_OF_USERS=2
LOCATION=germanywestcentral

# Create users
for i in $(seq 1 $NUMBER_OF_USERS);
do
    PASSWORD=$(randpw)
    az ad user create \
        --display-name "MicroHack Participant ${i}" \
        --password "${PASSWORD}" \
        --user-principal-name "mhp-${i}@mngenvmcap323185.onmicrosoft.com" > mhp-${i}.json
    echo $PASSWORD > mhp-${i}_password.txt

done


# Create resource groups, assign role assignments.
for i in $(seq 1 $NUMBER_OF_USERS);
do
    RG_ID=$(az group create \
        --resource-group mhp-${i} \
        --location ${LOCATION} \
        --query id \
        --output tsv)
    USER_PRINCIPAL_NAME=$(cat mhp-${i}.json | jq -r '.userPrincipalName')
    az role assignment create \
        --assignee ${USER_PRINCIPAL_NAME} \
        --role Contributor \
        --scope ${RG_ID}
done
