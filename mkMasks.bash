#!/usr/bin/env bash
set -euo pipefail
trap 'e=$?; [ $e -ne 0 ] && echo "$0 exited in error"' EXIT
cd $(dirname $0)

#
# 20180911 - create flashcards from afni whereami atlas
#
atlas=TT_Daemon 
#atlas=CA_N27_ML
[ ! -d masks/$atlas ] && mkdir -p masks/$atlas
whereami -atlas $atlas -show_atlas_code|
 grep -iv Left |
 grep -v Brodman|
 grep : | 
 while IFS=":" read side area roi; do
     out=masks/$atlas/${area// /_}
     [ -r $out.nii.gz ] && continue
     whereami  -mask_atlas_region "$atlas:$side:$area" -prefix $out.nii.gz
     3dcalc -overwrite -a $out.nii.gz -expr a*$roi -prefix $out.nii.gz
     3dCM $out.nii.gz > $out.txt
done
3dbucket -overwrite -prefix masks/$atlas.nii.gz masks/$atlas/*.nii.gz
3dTstat -overwrite -max -prefix masks/$atlas.all.nii.gz masks/$atlas.nii.gz
