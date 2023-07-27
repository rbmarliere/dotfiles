#!/bin/bash

opt=
[ "$1" = "2" ] && opt=-s

mkdir -p ~/Pictures/Screenshots

f=~/Pictures/Screenshots/$(date +%Y%m%d%H%M%S).png

maim $opt -u $f

xclip -selection clipboard -t image/png -i $f

