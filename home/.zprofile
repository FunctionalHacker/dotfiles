if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	LIBSEAT_BACKEND=logind gamescope \
		-e -f -U \
		-W 3840 -H 2160 \
		-w 1920 -h 1080 \
		-- steam -gamepadui -steamos
fi
