#!/bin/bash

RESP=$(cat <<EOF | fzf +s --tac
Shutdown
Reboot
Suspend
Lock
Exit
EOF
);

case "$RESP" in
	Shutdown)
		systemctl poweroff
		;;
	Reboot)
		systemctl reboot
		;;
	Suspend)
		systemctl suspend
		;;
	Lock)
		loginctl lock-session $(loginctl show-user $USER -p Sessions | cut -d'=' -f2)
		;;
	Exit)
		swaymsg exit
		;;
	*)
		exit 1
esac
