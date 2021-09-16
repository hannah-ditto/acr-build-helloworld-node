#!/bin/bash
. variables.config

az acr task create \
    --registry $ACR_NAME \
    --name multisteptask \
    --context "https://github.com/$GIT_USER/$REPO_PATH#$REPO_BRANCH" \
    --file "../taskmulti.yaml" \
    --git-access-token $GIT_PAT