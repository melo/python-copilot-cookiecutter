#!/bin/sh

set -ex

git init
git add .
git ci -s -m 'Initial setup'

pre-commit install
