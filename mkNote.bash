#!/usr/bin/env bash
set -euo pipefail
trap 'e=$?; [ $e -ne 0 ] && echo "$0 exited in error"' EXIT

#
# make an anki note import csv from region, location, and description
#

[ $# -lt 1 ] && atlas="TT_Daemon" || atlas="$1"


# print image as html
pimg() { echo -n "\"<img src='$1'/>\""; }

# anki import doesn't like this
# echo roi,rai_xyz,imgaxi,imgsag,imgcor,wikiurl,desc

# for each summary file, make a note
for s in masks/$atlas/*.smry; do
   d=$(dirname $s)
   bn=$(basename $s .smry);
   name=$(echo $bn |sed 's/Right_//;s/_/ /g')
   url=$(sed -n /^http/p $s)
   desc=$(perl -lne 'next if /^http/;s/\n/<br>/g;s/"/\\"/g;print' $s)
   rai_xyz=$(cat $d/$bn.txt)
cat <<HD
$name,"$rai_xyz",$(pimg $bn.axi.jpg),$(pimg $bn.sag.jpg),$(pimg $bn.cor.jpg),"$url","$desc"
HD
   
done > notes_${atlas}.csv
