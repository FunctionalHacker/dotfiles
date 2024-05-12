  # Launch or attach zellij to existing session if logging in over ssh
if [[ -z "$ZELLIJ" && -n "$SSH_CONNECTION" ]]; then
  exec zellij attach -c SSH
fi
