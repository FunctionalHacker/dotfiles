if [[ -z "$ZELLIJ" ]]; then
  # Launch or attach to existing session if logging in over ssh
  if [[ -n "$SSH_CONNECTION" ]]; then
    exec zellij attach -c SSH
  # Launch a new local session otherwise
  else
    exec zellij
  fi
fi
