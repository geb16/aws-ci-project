#!/bin/bash
set -e

APP_NAME="sample-flask-app"

if [ -z "$(docker ps -q -f name=$APP_NAME)" ]; then
  echo "Container $APP_NAME is not running."
  exit 1
fi
