# Supports 'tmux', 'zellij', 'none'
PLEXER=tmux

if [[ "$PLEXER" == 'tmux' ]]; then
  PLEXER_ACTIVE="$TMUX"
  PLEXER_CMD="tmux new-session -A -s SSH"
elif [[ "$PLEXER" == 'zellij' ]]; then
  PLEXER_ACTIVE="$ZELLIJ"
  PLEXER_CMD="zellij attach -c SSH"
fi

# Launch or attach to existing multiplexer session if logging in over ssh
if [[ -n "$PLEXER_CMD" && -z "$PLEXER_ACTIVE" && -n "$SSH_CONNECTION" ]]; then
  eval "exec $PLEXER_CMD"
fi
