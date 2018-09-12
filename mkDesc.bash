#!/usr/bin/env bash
set -eu #o pipefail
trap 'e=$?; [ $e -ne 0 ] && echo "$0 exited in error"' EXIT

#
# get wikipedia summary for files
#

atlas=TT_Daemon

# reconcile TT_Daemon with wikipedia names
#  wc -w masks/TT_Daemon/*smry|sort -nr # see bad entries
fixname(){
   echo $1| tr [A-Z] [a-z] |
   sed 's/right_//;s/_/ /g;
    s/^caudate$/Caudate nucleus/;
    s/^pyramids$/Medullary pyramids/;
    s/^anterior nucleus$/Anterior nuclei of thalamus/;
   ';
}

for f in masks/$atlas/*txt; do
   name=$(basename $f .txt)
   out=masks/$atlas/$name.smry
   [ -r $out ] && continue
   newname=$(fixname $name)
   echo $newname
   wiki -n "$newname" | sed '/^Read more: %s$/d' | tee  $out
   sleep 1 # wikipedia can probably handle our calls, but lets be nice
done
