# Launch tmux if logging in over ssh
if [[ -z "$TMUX" ]] && [[ -n "$SSH_CONNECTION" ]]; then
  if tmux has-session -t ssh_tmux 2>/dev/null; then
    exec tmux -2 attach-session -t ssh_tmux
  else
    exec tmux -2 new-session -s ssh_tmux
  fi
fi
