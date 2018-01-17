#!/bin/bash

. env.sh

gsutil ls gs://$BUCKET/spectre/
