#!/bin/bash

TYPE=$(cat <<EOF | fzf
Region
One monitor
All monitors
EOF
);

LOC=$(cat <<EOF | fzf
Copy to clipboard
Save as
Save with a generated name
EOF
);

swaymsg move container to workspace 9

case "$TYPE" in
	Region)
		case "$LOC" in

			Copy to clipboard)
				grim -g "$(slurp)" | wl-copy
				;;
			Save as)
				grim -g "$(slurp)"
				;;
			Save with a generated name)
				grim -g "$(slurp)" $(xdg-user-dir PICTURES)/Screenshots/$(date +'%Y-%m-%d-%H%M%S.png')
				;;
			*)
				exit 1
		esac
		;;
	One monitor)
		case "$LOC" in

			Copy to clipboard)
				;;
			Save as)
				;;
			Save with a generated name)
				;;
			*)
				exit 1
		esac
		;;
	All monitors)
		case "$LOC" in

			Copy to clipboard)
				;;
			Save as)
				;;
			Save with a generated name)
				;;
			*)
				exit 1
		esac
		;;
	*)
		exit 1
esac
