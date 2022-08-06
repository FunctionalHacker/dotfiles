if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	{%@@ if profile == 'Moria' @@%}
	systemctl --user mask pipewire.service pipewire-pulse.service && systemctl --user stop pipewire.service pipewire-pulse.service && kodi; systemctl --user unmask pipewire.service pipewire-pulse.service && systemctl --user start pipewire.service pipewire-pulse.service
	{%@@ elif profile == 'Mirkwood' @@%}
	sway-run
	{%@@ endif @@%}
fi
