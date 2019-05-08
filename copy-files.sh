#!/bin/bash
set -ex
cp /usr/local/bin/docker-credential-* /workspace/bin
cp $HOME/.docker/config.json /workspace/.docker/
