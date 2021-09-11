#!/bin/bash
. variables.config

# Delete the resource group, which will also delete any keyvaults, images, or tasks.
az group delete --resource-group $RES_GROUP -y
az ad sp delete --id $ACR_NAME-pull