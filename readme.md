# Anki Deck from a MR atlas

## Usage

1. Import json w/ [CrowdAnki](https://github.com/Stvad/CrowdAnki)

## Editing
To edit notes:
 1. Fork and pull repo
 2. Import, edit, and export json (via [CrowdAnki](https://github.com/Stvad/CrowdAnki))
 3. Push changes, create pull request

To generate a new atlas:
 1. change `atlas=` in `*bash` files
 2. run `make all`
 3. import csv file

## How
 1. Atlas images built with AFNI's bundled `TT_Daemon`.
    * `whereami` to get mask
    * `3dCM` to get roi center
    * `afni` to generate jpg
 2. wikipedia summary generated with [`walle/wiki`](https://github.com/walle/wiki)
 3. csv notes imported into anki and exported with [CrowdAnki](https://github.com/Stvad/CrowdAnki)

## TODO
use freesurfer labels (`aparc`)

## Anki Plugins
 * [CrowdAnki](https://github.com/Stvad/CrowdAnki): `1788670778`
 * ~~[AnkiHub](https://github.com/dayjaby/AnkiHub): `116826216`~~ not available for Anki 2.1
