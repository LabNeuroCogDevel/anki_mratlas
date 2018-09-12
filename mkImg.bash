#!/usr/bin/env bash
set -e
trap 'e=$?; [ $e -ne 0 ] && echo "$0 exited in error"' EXIT

#
# use nii.gz from mkMasks.bash to make jpg files to include in anki
#
atlas=TT_Daemon
afni -yesplugouts         \
   -com 'SET_XHAIRS OFF'  \
   -com 'SET_UNDERLAY TT_152_2009c+tlrc'  \
   -com "OPEN_WINDOW sagittalimage opacity=6" \
   -com "OPEN_WINDOW axialimage opacity=6"    \
   -com "OPEN_WINDOW coronalimage opacity=6"  \
   -dset /usr/share/afni/atlases/TT_152_2009c+tlrc.HEAD \
         masks/$atlas/*.nii.gz
   #masks/$atlas.nii.gz

echo "waiting 5 second for afni to be all started"
sleep 5 

grep . masks/$atlas/*txt|while IFS=":" read f xyz; do 
  bf=$(basename $f .txt)
  echo $bf
  [ ! -r masks/$atlas/$bf.axi.jpg ] && 
    plugout_drive \
     -com "SET_DICOM_XYZ $xyz" \
     -com "SET_OVERLAY $bf.nii.gz"  \
     -com "SAVE_JPEG sagittalimage masks/$atlas/$bf.sag.jpg blowup=2"     \
     -com "SAVE_JPEG coronalimage  masks/$atlas/$bf.cor.jpg blowup=2"     \
     -com "SAVE_JPEG axialimage    masks/$atlas/$bf.axi.jpg blowup=2"     \
     -quit
  [ -r masks/$atlas/$bf.jpg ] && rm masks/$atlas/$bf.jpg
  [ ! -r masks/$atlas/$bf.all.jpg ] &&
  convert +append masks/$atlas/$bf.{axi,cor,sag}.jpg masks/$atlas/$bf.all.jpg
done


plugout_drive -com QUIT
