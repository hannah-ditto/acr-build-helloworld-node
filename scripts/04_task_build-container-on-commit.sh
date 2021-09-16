#!/bin/bash
. variables.config

az acr task create \
    --registry $ACR_NAME \
    --name buildoncommit \
    --image helloworld:{{.Run.ID}} \
    --context "https://github.com/$GIT_USER/$REPO_PATH#$REPO_BRANCH" \
    --file "../Dockerfile" \
    --git-access-token $GIT_PAT