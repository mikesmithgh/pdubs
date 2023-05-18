#!/bin/sh
set -e
cd ~/output || exit 1
until [ -f ci-results.json ]
do
  printf "waiting for pdubs results..."
  sleep 15
done
jq --exit-status .[0].kCGWindowOwnerName ci-results.json >/dev/null

