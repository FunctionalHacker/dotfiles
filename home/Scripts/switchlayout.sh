#!/bin/bash
curLayout=$(setxkbmap -query | grep layout | sed 's/layout:     //g')

if [ $curLayout == "eu" ]; then
  setxkbmap dvorak
else
  setxkbmap eu
fi
