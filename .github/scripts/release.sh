#!/usr/bin/env bash
set -ex
swift build -c release --arch arm64 --arch x86_64
cd .build/apple/Products/Release || exit 1
tar -czvf pdubs.tar.gz pdubs
shasum --algorithm 256 pdubs.tar.gz | tee pdubs.tar.gz.sha256
shasum -c pdubs.tar.gz.sha256

