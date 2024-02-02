#!/usr/bin/bash
randpw(){ < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-16};echo;}

source ./env.sh

# Create users
for i in $(seq 1 $NUMBER_OF_USERS);
do
    PASSWORD=$FIX_PASSWORD #$(randpw)
    az ad user create \
        --display-name "MicroHack Participant ${i}" \
        --password "${PASSWORD}" \
        --user-principal-name "mhp-${i}@${DOMAIN_SUFFIX}" > mhp-${i}_details.json
    echo $PASSWORD > mhp-${i}_password.txt
    az ad user update \
        --id "mhp-${i}@${DOMAIN_SUFFIX}" \
        --account-enabled false
done


# Create resource groups, assign role assignments.
for i in $(seq 1 $NUMBER_OF_USERS);
do
    RG_ID=$(az group create \
        --resource-group mhp-${i} \
        --location ${LOCATION} \
        --subscription ${TARGET_SUBSCRIPTION} \
        --query id \
        --output tsv)
    USER_PRINCIPAL_NAME=$(cat mhp-${i}_details.json | jq -r '.userPrincipalName')
    az role assignment create \
        --assignee ${USER_PRINCIPAL_NAME} \
        --role Contributor \
        --scope ${RG_ID}
done
