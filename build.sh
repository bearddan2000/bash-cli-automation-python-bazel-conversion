#! /bin/bash

d=$1
e=$d/bin

if [[ -e $e ]]; then

  #copy BUILD file from src folder
  cp .src/WORKSPACE $e/WORKSPACE

  #based on platform
  #copy BUILD file from src folder
  case $d in
    *web* ) cp .src/BUILD-web $e/BUILD ;;
    *desktop* ) cp .src/BUILD-cli $e/BUILD ;;
    *cli* ) cp .src/BUILD-cli $e/BUILD ;;
  esac

  REQ=""
  #iterate through the requirements file
  for r in `cat $e/requirements.txt`; do
    #if this is the first requirement
    if [[ -z $REQ ]]; then
      REQ="requirement('${r}'),"
    else
      # else if +1 requirement
      REQ="\n${REQ}requirement('${r}'),"
    fi
  done

  #replace marker ;; in BUILD file
  sed -i "s/;;/$REQ/g" $e/BUILD
fi
