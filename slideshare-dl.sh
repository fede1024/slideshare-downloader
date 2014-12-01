#!/bin/bash

DPI=128
DOWNLOAD_THREADS=5
CONVERSION_THREADS=4
DELETE_TMP=true
OUTPUT_FILE="output.pdf"

# Find slideshow xml
list_addr=`wget -q -O- "$1" | grep -o -E '<meta name="thumbnail" content="[^?]*' | grep -o 'http.*'`

if [ -z "$list_addr" ]; then
    echo "Page format unknown :("
    exit 1
fi

# Get list of slides
list_addr=`echo $list_addr | sed s-ss_thumbnails/-- | sed s/-thumbnail.jpg/.xml/`

files=`wget -q -O- "$list_addr" | grep -o 'https[^"]*'`

if [ -z "$files" ]; then
    echo "Cannot download list of slide :("
    exit 1
fi

tmp=`mktemp -d`

echo 'Downloading in' $tmp

# Download
echo "$files" | xargs -n1 -P$DOWNLOAD_THREADS  wget -q -P $tmp

echo "Converting to png"

find "$tmp" -name '*.swf' | xargs -n1 -P$CONVERSION_THREADS -i swfrender -r $DPI '{}' -o '{}'.png

echo "Merge into pdf"
pngs=`find "$tmp" -name '*png' | sort --version-sort`
convert $pngs $OUTPUT_FILE

echo "Done. $OUTPUT_FILE created."

if [ "$DELETE_TMP" = true ]
then
    rm -rf $tmp
fi

