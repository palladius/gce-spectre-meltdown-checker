#! /bin/bash

# This is a startup script which tries to install Spectre check code.
# It should be perfectly safe but - as usual - USE AT YOUR OWN RISK!
# (also because it depends on 3rd-party code).


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
gsutil cp check.out gs://$BUCKET/spectre/$PROJECTID/$HOSTNAME.check
gsutil cp bugs.out gs://$BUCKET/spectre/$PROJECTID/$HOSTNAME.cpuinfo

touch 02-startup-end.sh
