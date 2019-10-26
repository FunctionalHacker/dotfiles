#!/bin/sh
 
 
gr="FocalTechPS/2 FocalTech Touchpad"
#gr="SynPS/2 Synaptics TouchPad"
 
 
#Creates a file if it does not exist to store the 0 or 1 bit to check if touchpad is enabled or disabled. Set to 0 by default
if [ ! -f .touchpad ];
        then
                echo 0 > .touchpad;
 
fi
 
if grep -q 0 ".touchpad";
then
        xinput enable "$gr";
        echo 1 > .touchpad;
        echo "Touchpad enabled"
        notify-send "Touchpad enabled"
else
        xinput disable "$gr";
        echo 0 > .touchpad;
        echo "Touchpad Disabled"
        notify-send "Touchpad disabled"
fi
