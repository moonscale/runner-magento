#!/bin/sh

TAG_NAME=${TAG_NAME:-"local"}

set -e

docker pull php:5.6-apache
docker build -t moonscale/runner-magento:${TAG_NAME} .
