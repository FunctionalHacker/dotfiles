#!/bin/bash
swaylock="$HOME/Scripts/swaylock.sh"
dimscreen="$HOME/Scripts/dim-screen.sh"
screenon="swaymsg 'output * dpms on'"
screenoff="swaymsg 'output * dpms off'"
swayidle \
	lock "$swaylock" \
	timeout 300 "$dimscreen -sd" \
    resume "$dimscreen -r" \
	timeout 600 "loginctl lock-session; sleep 0.5; $screenoff" \
    resume "$screenon; $dimscreen -r" \
	before-sleep "playerctl pause; loginctl lock-session" \
	unlock "pkill -9 swaylock"
