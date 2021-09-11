#!/bin/bash
. variables.config

az container create \
    --resource-group $RES_GROUP \
    --name acr-tasks \
    --image "$ACR_NAME.azurecr.io/$IMAGE_NAME:$IMAGE_VERSION" \
    --registry-login-server $ACR_NAME.azurecr.io \
    --registry-username $(az keyvault secret show --vault-name $AKV_NAME --name $ACR_NAME-pull-usr --query value -o tsv) \
    --registry-password $(az keyvault secret show --vault-name $AKV_NAME --name $ACR_NAME-pull-pwd --query value -o tsv) \
    --dns-name-label acr-tasks-$ACR_NAME \
    --query "{FQDN:ipAddress.fqdn}" \
    --output table

    ##az container attach --resource-group $RES_GROUP --name acr-tasks