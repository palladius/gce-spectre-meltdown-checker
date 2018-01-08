#!/bin/bash

echo Destryong these VMs:

gcloud --project ric-cccwiki compute instances list | egrep "^test-vuln-"

# todo
# gcloud --project ric-cccwiki compute instances delete test-vuln-debian-9-drawfork-v20180102 --yes --delete-disks
