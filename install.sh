#! /bin/bash

for d in `ls -la | grep ^d | awk '{print $NF}' | egrep -v '^\.'`; do

  rm -f $d/install.sh

  if [[ -e $d/Dockerfile ]]; then
    #statements
    rm -f $d/Dockerfile
  fi

  case $d in
    *web* )
      echo "web" &&
       cp .src/install-web.sh $d/install.sh &&
       ./readme.sh $d "web";;
    *desktop* )
      echo "desktop" &&
       cp .src/install-cli.sh $d/install.sh &&
       ./readme.sh $d "desktop";;
    *cli* )
      echo "cli" &&
       cp .src/install-cli.sh $d/install.sh &&
       ./readme.sh $d "cli";;
  esac

  ./build.sh $d

  ./folder.sh $d

done
