#!/bin/sh

tmpfile=/tmp/xcolor.tmp

if [[ $1 == "light" ]]; then
  xinclude='#include "/home/thib/.xcolors/solarized.light.xcolors"'
else
  xinclude='#include "/home/thib/.xcolors/solarized.xcolors"'
fi

echo $xinclude

echo $xinclude > $tmpfile

xrdb -merge $tmpfile

rm $tmpfile
