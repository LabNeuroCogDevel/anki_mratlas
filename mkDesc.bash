#!/usr/bin/env bash
set -euo pipefail
trap 'e=$?; [ $e -ne 0 ] && echo "$0 exited in error"' EXIT

#
# get wikipedia summary for files
#

atlas=TT_Daemon

fixname(){
   echo $1|
   sed 's/Right_//;s/_/ /g;
    s/^Caudate$/Caudate Nucleus/;
   ';
}

for f in masks/$atlas/*txt; do
   name=$(basename $f .txt)
   out=masks/$atlas/$name.smry
   [ -r $out ] && continue
   newname=$(fixname $name)
   echo $newname
   wiki "$newname" |tee  $out
   break
   sleep 1 # dont kill wikipedia
done
