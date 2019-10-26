#!/bin/bash

displays=$(xrandr | grep " connected" | wc -l)
if [ $displays -eq 1 ]; then
  i3lock-fancy; echo "systemctl suspend" > /home/reekymarko/Scripts/suspendcommand
else
  echo "won't suspend, external display connected"
  echo " " > /home/reekymarko/Scripts/suspendcommand
fi
