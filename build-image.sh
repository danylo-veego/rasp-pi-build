#!/bin/bash

sudo docker build --build-arg user_id="$(id -u)" --build-arg group_id="$(id -g)" -t rdk-pi-build-env:latest ./docker/
