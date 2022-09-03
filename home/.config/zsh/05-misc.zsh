# Launch tmux if logging in over ssh
if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
	if tmux has-session &2>/dev/null; then
    	exec tmux attach-session -t ssh_tmux
	else
		exec tmux new-session -s ssh_tmux
	fi
fi

# share history between running zsh instances
setopt share_history

# ignore commands with leading space from history
setopt histignorespace
