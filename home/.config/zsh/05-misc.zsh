# Launch tmux if logging in over ssh
if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
    exec tmux attach-session -t ssh_tmux || exec tmux new-session -s ssh_tmux
fi

# share history between running zsh instances
setopt share_history

# ignore commands with leading space from history
setopt histignorespace
