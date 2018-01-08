#!/bin/bash

echo Destryong these VMs:

source env.sh

gcloud --project $PROJECT_ID compute instances list | egrep "^test-vuln-"

# todo
# gcloud --project $PROJECT_ID compute instances delete test-vuln-debian-9-drawfork-v20180102 --yes --delete-disks
