#! /bin/bash

PROJECTID=$(curl http://metadata/0.1/meta-data/project-id)
HOSTNAME=$(/bin/hostname)
BUCKET=$(curl http://metadata/0.1/meta-data/mybucket)
VER=1.1

touch 01-startup-start.sh

git clone https://github.com/speed47/spectre-meltdown-checker 
cd spectre-meltdown-checker 
sudo ./spectre-meltdown-checker.sh  | tee spectre.out 
# According to Muharem, if cat /proc/cpuinfo under "bugs:" is:
# 1. empty it's bad
# 2. contains some bug: good.
# See: https://askubuntu.com/questions/992137/how-to-check-that-kpti-is-enabled-on-my-ubuntu
sudo cat /proc/cpuinfo | grep bugs  | tee bugs.out
gsutil cp check.out gs://$BUCKET/$PROJECTID/$HOSTNAME.check
gsutil cp bugs.out gs://$BUCKET/$PROJECTID/$HOSTNAME.cpuinfo

touch 02-startup-end.sh
