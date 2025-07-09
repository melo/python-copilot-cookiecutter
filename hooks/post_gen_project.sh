#!/bin/sh

set -ex

uv --no-managed-python sync

git init
git add .
git ci -s -m 'Initial setup'

pre-commit install
