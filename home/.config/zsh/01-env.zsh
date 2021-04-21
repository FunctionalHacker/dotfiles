# zsh key timeout
export KEYTIMEOUT=1

# prompt customization
export PURE_PROMPT_SYMBOL="λ"
export PURE_PROMPT_VICMD_SYMBOL="y"

# zsh history settings
export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000

# Variable to pass to sdotdrop to get current user
export USRNAME=$USER

# go path
export GOPATH=~/.bin/go

# fzf settings
export FZF_DEFAULT_COMMAND='fd -Ht f'
export FZF_ALT_C_COMMAND='fd -Ht d'
export FZF_DEFAULT_OPTS='-m --bind ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all'
export FZF_COMPLETION_TRIGGER='**'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "/usr/bin/cat {} | nvimpager -c "'

# use lesspipe with less
export LESSOPEN="|lesspipe.sh %s"

# dotfile repository location
export DOTREPO="$HOME/git/dotfiles"

# nvim ftw!
export EDITOR=nvim
export PAGER="nvimpager -p"
export AUR_PAGER=$PAGER

# Use GPG for SSH authentication
export GPG_TTY="$(tty)"

# set SSH_AUTH_SOCK if not logging in over SSH
if [ "$SSH_CONNECTION" -eq "" ]; then
	export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
	gpgconf --launch gpg-agent
fi

# tehfuk
eval $(thefuck --alias)
