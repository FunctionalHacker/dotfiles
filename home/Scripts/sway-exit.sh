#!/bin/bash

RESP=$(cat <<EOF | fzf
Exit
Sleep
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
	*)
		exit 1
esac
