#!/bin/bash
. variables.config

# Create KeyVault (without soft-delete)
az keyvault create --resource-group $RES_GROUP --name $AKV_NAME

# Obtain the full registry ID for subsequent command args
ACR_REGISTRY_ID=$(az acr show --name $ACR_NAME --query id --output tsv)

# Create service principal, store its password in AKV (the registry *password*)
# # Default permissions are for docker pull access. Modify the '--role'
# # argument value as desired:
# # acrpull:     pull only
# # acrpush:     push and pull
# # owner:       push, pull, and assign roles
 ## MSYS_NO_PATHCONV needed to work inside Git Bash
az keyvault secret set \
  --vault-name $AKV_NAME \
  --name $ACR_NAME-pull-pwd \
  --value $(MSYS_NO_PATHCONV=1 az ad sp create-for-rbac \
                --name $ACR_NAME-pull \
                --scopes $(az acr show --name $ACR_NAME --query id --output tsv) \
                --role acrpull \
                --query password \
                --output tsv)

# Store service principal ID in AKV (the registry *username*)
az keyvault secret set \
    --vault-name $AKV_NAME \
    --name $ACR_NAME-pull-usr \
    --value $(az ad sp list --display-name $ACR_NAME-pull --query [].appId --output tsv)