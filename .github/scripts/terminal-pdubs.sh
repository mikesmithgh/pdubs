#!/bin/sh
set -e
cd "$GITHUB_WORKSPACE" || exit 1
swift run 1> ~/output/ci-results.json 2> ~/output/ci-stderr.log

