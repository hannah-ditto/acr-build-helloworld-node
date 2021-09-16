#!/bin/bash
. variables.config

az acr build --registry $ACR_NAME --image baseimages/node:15-alpine --file "../Dockerfile-base" .

az acr task create \
    --registry $ACR_NAME \
    --name baseexample1 \
    --image helloworld:{{.Run.ID}} \
    --arg REGISTRY_NAME=$ACR_NAME.azurecr.io \
    --context "https://github.com/$GIT_USER/$REPO_PATH#$REPO_BRANCH" \
    --file Dockerfile-app \
    --git-access-token $GIT_PAT