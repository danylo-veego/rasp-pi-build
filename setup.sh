#!/bin/bash

mkdir -p build/kirkstone

if [ ! -f "docker/.gitconfig" ]; then
  echo "No .gitconfig found in docker/ or $HOME"
  if [ "$#" -lt "4" ]; then
    if [ -f "$HOME/.gitconfig" ]; then
      echo "Using $HOME/.gitconfig"
      cp "$HOME/.gitconfig" docker/.gitconfig
    else
      echo "No .gitconfig found in $HOME"
      echo "Usage: $0 LOGIN PASSWORD NAME EMAIL"
      exit 1
    fi
  fi

  cat docker/gitconfig-template | sed "s/NAME/$3/g" | sed "s/EMAIL/$4/g" >docker/.gitconfig

  if [ ! -f docker/.gitconfig ]; then
    echo "Failed to create .gitconfig"
    exit 1
  fi

  echo "Created .gitconfig:"
  cat docker/.gitconfig
  echo "EOF"
  echo
fi

if [ ! -f docker/.netrc ]; then
  echo "No .netrc found in docker/"
  if [ "$#" -lt 2 ]; then
    echo "Usage: $0 USERNAME PASSWORD"
    exit 1
  fi
  cat docker/net-rc-template | sed "s/USERNAME/$1/g" | sed "s/PASSWORD/$2/g" >docker/.netrc

  if [ ! -f docker/.netrc ]; then
    echo "Failed to create .netrc"
    exit 1
  fi
  echo "Created .netrc:"
  cat docker/.netrc
  echo "EOF"
  echo
fi

./build-image.sh
