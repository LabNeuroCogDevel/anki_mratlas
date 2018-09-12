# Anki Deck from a MR atlas

This generates an [anki](https://apps.ankiweb.net/) deck with flashcards for each atlas roi. 

## Usage
To use the deck, see [LabNeuroCogDevel/TTDaemonCards](https://github.com/LabNeuroCogDevel/TTDaemonCards).

## Generating

To generate a new atlas:
 1. change `atlas=` in `*bash` files
 2. run `make all`
 2. Optionally, get predefined note type and cards by import json from  [LabNeuroCogDevel/TTDaemonCards](https://github.com/LabNeuroCogDevel/TTDaemonCards) via the [CrowdAnki](https://github.com/Stvad/CrowdAnki) add-on.
 3. import csv file

## How
 1. Atlas images built with AFNI's bundled `TT_Daemon`.
    * `whereami` to get mask
    * `3dCM` to get roi center
    * `afni` to generate jpg
 2. wikipedia summary generated with [`walle/wiki`](https://github.com/walle/wiki)
 3. csv notes imported into anki and exported with [CrowdAnki](https://github.com/Stvad/CrowdAnki)

## TODO
 * use freesurfer labels (`aparc`)
 * git submodules for created decks

