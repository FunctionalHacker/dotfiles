if cat /proc/cmdline | grep -q "video=eDP-1:d"; then 
	[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && kodi
else
	[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && $HOME/Scripts/sway-run.sh > /dev/null 2>&1
fi
