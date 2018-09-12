#!/usr/bin/env bash
set -euo pipefail
trap 'e=$?; [ $e -ne 0 ] && echo "$0 exited in error"' EXIT

#
# sync media with anki
#
atlas=TT_Daemon

mediadir="$(find $HOME/.local/share/ -name 'collection.media' -type d)"
[ ! -r "$mediadir" ] && echo "cannot find single collection.media directory" && exit 1
rsync -vhr masks/$atlas/*.{axi,sag,cor}.jpg "$mediadir/"
