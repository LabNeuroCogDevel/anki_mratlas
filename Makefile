.PHONY: image all anki_image_install anki_import
all: images notes_TT_Daemon.csv anki_image_install anki_import:

image: mkImg.bash mkMasks.bash 
	./mkMasks.bash
	./mkImg.bash

notes_TT_Daemon.csv: image
	./mkNote.bash TT_Daemon

anki_image_install:
	./sync_media.bash

anki_import:
	echo "you'll have to do this by hand! import json to get note-type"
