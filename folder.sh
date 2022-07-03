#! /bin/bash

d=$1

new_folder=`head -n 1 $d/README.md | sed 's/# //g'`

mv $d $new_folder
