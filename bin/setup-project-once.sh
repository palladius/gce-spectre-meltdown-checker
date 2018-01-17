#!/bin/bash

# setup-project-once.sh

source env.sh

VER=1.1

# this is before the set -e as it yields error after first time (hence NOT repeatable).
gsutil mb gs://$BUCKET/

set -e
set -x

gsutil cp VERSION gs://$BUCKET/spectre/gce-spectre-meltdown-checker.VERSION

gcloud --project $PROJECT_ID compute project-info add-metadata --metadata mybucket=$BUCKET,GCE_SPECTRE_VULN_SCAN_VERSION=$VER

touch setup-once.touch