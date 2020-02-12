#!/usr/bin/env bash

FILE=$1
FILE_NO_EXT=${FILE%.pd}
FILE_NO_EXT=${FILE_NO_EXT%.md}
pandoc $FILE -o $FILE_NO_EXT.pdf
pkill -HUP mupdf
