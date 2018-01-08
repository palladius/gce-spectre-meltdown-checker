#!/bin/bash

source "env.sh"


VERSION="$(cat VERSION)"

set -x

#gcloud config set project "$PROJECT_ID"

#OS="debian"
IMAGE=debian-9-drawfork-v20180102
SCOPES="https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring.write","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append"


for IMAGE in IMAGES ; do
	# "debian-9-drawfork-v20180102" => "debian"

	SHORT_IMAGE_NAME=$( echo "$IMAGE" | cut -f 1 -d- )
	gcloud beta compute --project "$PROJECT_ID" \
	  instances create "test-vuln-$SHORT_IMAGE_NAME" \
	  --zone "$ZONE" \
	  --machine-type "f1-micro" \
	  --network "default" \
	  --maintenance-policy "MIGRATE" \
	  --min-cpu-platform "Automatic" --tags "http-server" \
	  --image "$IMAGE" \
	  --metadata-from-file startup-script=startup-scripts/spectre-check.sh \
	   --image-project "eip-images" \
	   --boot-disk-size "10" \
	   --boot-disk-type "pd-standard" 
	touch created-$SHORT_IMAGE_NAME-v$VER.touch
done
