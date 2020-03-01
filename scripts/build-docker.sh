#!/bin/sh

. scripts/env.sh

docker build -t "$PROXY_DOCKER_USER/proxy:latest" -f .buildkite/Dockerfile .
