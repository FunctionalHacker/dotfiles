if [[ -z $DISPLAY && $XDG_VTNR -eq 6 ]]; then
  systemctl --user mask pipewire.service pipewire-pulse.service
  systemctl --user stop pipewire.service pipewire-pulse.service
  kodi --standalone
  systemctl --user unmask pipewire.service pipewire-pulse.service
  exit
fi
