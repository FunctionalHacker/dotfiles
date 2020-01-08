#!/bin/bash

RESP=$(cat <<EOF | fzf
Exit
Suspend
Lock
Reboot
Shutdown
EOF
);

case "$RESP" in
	Exit)
		swaymsg exit
		;;
	Sleep)
		systemctl suspend
		;;
	Reboot)
		systemctl reboot
		;;
	Shutdown)
		systemctl poweroff
		;;
	Lock)
		loginctl lock-session
		;;
	*)
		exit 1
esac
