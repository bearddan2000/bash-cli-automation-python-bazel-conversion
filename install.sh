#! /bin/bash

for d in `ls -la | grep ^d | awk '{print $NF}' | egrep -v '^\.'`; do

  rm -f $d/install.sh

  if [[ -e $d/Dockerfile ]]; then
    #statements
    rm -f $d/Dockerfile
    cp .src/Dockerfile $d
    ./build.sh $d
  else
    rm -f $d/py-srv/Dockerfile
    cp .src/Dockerfile $d/py-srv
    ./build.sh $d
  fi

  if [[ -e $d/bin/requirements.txt ]]; then
    #statements
    cp .src/requirements.py $d/bin
    if [[ -e $d/bin/app.py ]]; then
      mv $d/bin/app.py $d/bin/main.py
    fi
  else
    #statements
    cp .src/requirements.py $d/py-srv/bin
    if [[ -e $d/py-svr/bin/app.py ]]; then
      mv $d/py-svr/bin/app.py $d/py-svr/bin/main.py
    fi
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


  ./folder.sh $d

done
