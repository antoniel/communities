#!/usr/bin/env bash
set -e

repo="getzion/communities"

version="test"

echo "building image: $repo:$version"

docker build -t $repo:$version .
