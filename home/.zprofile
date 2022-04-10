if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	{%@@ if profile == 'Moria' @@%}
	LIBSEAT_BACKEND=logind gamescope \
		-e -f -U \
		-W 3840 -H 2160 \
		-w 1920 -h 1080 \
		-- steam -gamepadui -steamos
	{%@@ elif profile == 'Mirkwood' @@%}
	sway-run
	{%@@ endif @@%}
fi
