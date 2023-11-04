#! /bin/bash

d=$1
e=$d/bin

if [[ -e $e ]]; then

  #copy WORKSPACE file from src folder
  cp .src/WORKSPACE $e/WORKSPACE

  #copy BUILD file from src folder
  cp .src/BUILD $e/BUILD

fi
