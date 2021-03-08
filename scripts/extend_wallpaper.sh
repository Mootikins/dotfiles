#!/usr/bin/env bash

GRAVITY=Center
PREVIEW=true
OUT_FILE=false

while getopts i:o:g:r:p flag; do
   case "${flag}" in
   g) GRAVITY=${OPTARG} ;;
   o) OUT_FILE=${OPTARG} ;;
   i) IN_FILE=${OPTARG} ;;
   r) ORIENTATION=${OPTARG} ;;
   p) PREVIEW=true ;;
   *) ;;
   esac
done

if [ -z ${IN_FILE+x} ] || [ -z ${OUT_FILE+x} ] || [ -z ${GRAVITY+x} ] || [ -z ${ORIENTATION+x} ]; then
   cat <<EOM
USAGE: $(basename $0) [OPTIONS] -i INPUT_IMAGE -o OUTPUT_IMAGE -g GRAVITY -r ORIENTATION

   REQUIRED ARGUMENTS
      -i INPUT_IMAGE          Input file to extend
      -o OUTPUT_IMAGE         Output file name
      -g GRAVITY              Which side to put the image on; valid options are the same as
                              imagemagick's gravity option: North, South, East, West, Center

                              Defaults to Center

      -r ORIENTATION          Desired orientation; options are:

                              p or portrait for portrait (9x16 ratio)
                              l or landscape for landscape (9x16 ratio)

                              Defaults to landscape

   OPTIONS
      -p       Show a preview of the output file with feh

EOM
   exit 1
fi

WIDTH=$(identify -format "%w" $IN_FILE)
HEIGHT=$(identify -format "%h" $IN_FILE)

ASPECT_RATIO=$(echo "$WIDTH / $HEIGHT" | bc -l)

if (($(echo "$ASPECT_RATIO > 2.7777777" | bc -l))); then
   echo "TOO WIDE"
   exit 1
fi

case "${ORIENTATION}" in
l | landscape)
   NEW_WIDTH=$(echo "$HEIGHT / 9 * 16" | bc -l)
   NEW_WIDTH=$(echo "($NEW_WIDTH+0.5)/1" | bc)
   NEW_HEIGHT=$HEIGHT
   ;;
p | portrait)
   NEW_WIDTH=$(echo "$HEIGHT / 16 * 9" | bc -l)
   NEW_WIDTH=$(echo "($NEW_WIDTH+0.5)/1" | bc)
   NEW_HEIGHT=$HEIGHT
   ;;
*)
   echo "Improper orientation specified -- see the help"
   exit 1
   ;;
esac

case "${GRAVITY}" in
West | North)
   START='0,0'
   END='0,0'
   ;;
East | South)
   START="${WIDTH},${HEIGHT}"
   END="${NEW_WIDTH},${NEW_HEIGHT}"
   ;;
Center)
   HEIGHT_HALF=$(echo "$HEIGHT / 2" | bc -l)
   WIDTH_HALF=$(echo "$WIDTH / 2" | bc -l)
   NEW_HEIGHT_HALF=$(echo "$NEW_HEIGHT / 2" | bc -l)
   NEW_WIDTH_HALF=$(echo "$NEW_WIDTH / 2" | bc -l)
   START="${WIDTH_HALF},${HEIGHT_HALF}"
   END="${NEW_WIDTH_HALF},${NEW_HEIGHT_HALF}"
   ;;
*)
   echo "Non-valid gravity supplied"
   exit 1
   ;;
esac

convert \
   $IN_FILE \
   -virtual-pixel Edge \
   -gravity $GRAVITY \
   -set option:distort:viewport ${NEW_WIDTH}x${NEW_HEIGHT} \
   -distort SRT "$START 1,1 0 $END" \
   $OUT_FILE

if [ "$PREVIEW" = true ]; then
   feh $OUT_FILE --scale-down --auto-zoom &
fi
