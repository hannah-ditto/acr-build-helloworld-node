#!/bin/bash
. variables.config

# Create Resource Groups and Container Registry
az group create --resource-group $RES_GROUP --location eastus
az acr create --resource-group $RES_GROUP --name $ACR_NAME --sku Standard --location eastus
az acr build --registry $ACR_NAME --image "$IMAGE_NAME:$IMAGE_VERSION" '../'