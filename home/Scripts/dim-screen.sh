#!/usr/bin/env bash

save="/tmp/bkl"

idle_backlight=0
fade_step_time=0.02

get_brightness() {
	float=$(light -G $1)
	printf '%.*f\n' 0 $float
}

save(){
	get_brightness > "$save"
}

resume(){
	val=$(cat "$save")
	set_backlight "$val"
}

set_backlight(){
	local level
	for level in $(eval echo {$(get_brightness)..$1}); do
		light -S $level
		sleep $fade_step_time
	done
}


while getopts "drs0" opt; do
	case $opt in
		d)
			set_backlight "$idle_backlight"
			;;
		r)
			resume
			;;
		s)
			save
			;;
		0)
			set_backlight 0
			;;
		*)
			exit 1
			;;
	esac
done
