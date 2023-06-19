#!/bin/bash

if [ -e /usr/bin/dockerd ]; then
  if ! systemctl is-active --quiet docker; then
    echo "starting docker";
    sudo systemctl start docker
  fi
fi

if [ -e /usr/bin/podman ]; then
  if ! systemctl is-active --quiet podman; then
    echo "starting docker";
    sudo systemctl start podman
  fi
fi


cargo install cross
cross build --target aarch64-unknown-linux-gnu
