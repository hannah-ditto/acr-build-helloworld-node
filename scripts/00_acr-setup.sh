#!/bin/bash
. variables.config

./01_create-resource-group-and-registry.sh
./02_create-service-principal.sh

sleep 45s

./03_container-create.sh