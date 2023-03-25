# Launch zellij if logging in over SSH
if [[ -z "$ZELLIJ" && -n "$SSH_CONNECTION" ]]; then
  exec zellij attach -c ssh
fi
