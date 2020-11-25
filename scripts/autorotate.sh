#!/bin/bash
function rotate_ms {
	case $1 in
		"normal")
			swaymsg output eDP-1 transform 0
			;;
		"right-up")
			swaymsg output eDP-1 transform 90
			;;
		"bottom-up")
			swaymsg output eDP-1 transform 180
			;;
		"left-up")
			swaymsg output eDP-1 transform 270
			;;
	esac
}

while IFS='$\n' read -r line; do
	rotation="$(echo $line | sed -En "s/^.*orientation changed: (.*)/\1/p")"
	[[ !  -z  $rotation  ]] && rotate_ms $rotation
done < <(stdbuf -oL monitor-sensor)
