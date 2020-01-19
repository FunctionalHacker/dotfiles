#!/bin/bash
swaylock="$HOME/Scripts/swaylock.sh"
dimscreen="$HOME/Scripts/dim-screen.sh"
screenon="swaymsg 'output * dpms on'"
screenoff="swaymsg 'output * dpms off'"
swayidle \
	lock "$swaylock" \
	timeout 300 "lqsd -d" \
    resume "lqsd -r" \
	timeout 600 "loginctl lock-session $(loginctl show-user $USER -p Sessions | cut -d'=' -f2); sleep 0.5; $screenoff" \
    resume "$screenon; $dimscreen -r" \
	before-sleep "playerctl pause; loginctl lock-session $(loginctl show-user $USER -p Sessions | cut -d'=' -f2)" \
	unlock "pkill -9 swaylock"
