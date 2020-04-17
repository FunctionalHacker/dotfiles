#!/bin/bash
swaylock="$HOME/.config/sway/scripts/lock.sh"
screenon="swaymsg 'output * dpms on'"
screenoff="swaymsg 'output * dpms off'"
swayidle \
	lock "$swaylock" \
	unlock "pkill -9 swaylock" \
	timeout 300 "lqsd -d" \
    resume "lqsd -r" \
	timeout 600 "loginctl lock-session" \
	timeout 610 "$screenoff" \
    resume "$screenon; lqsd -r" \
	before-sleep "playerctl pause; loginctl lock-session" \
