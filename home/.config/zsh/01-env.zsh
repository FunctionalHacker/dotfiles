# key timeout
export KEYTIMEOUT=1

# prompt customization
export PURE_PROMPT_SYMBOL="λ"
export PURE_PROMPT_VICMD_SYMBOL="y"

# history settings
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
# Ignore these functions from history since they will
# append the expandend command to the history
export HISTORY_IGNORE="(pi|pr)"
# Additional settings (source https://jdhao.github.io/2021/03/24/zsh_history_setup)
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY_TIME
setopt EXTENDED_HISTORY

# Variable to pass to sdotdrop to get current user
export USRNAME=$USER

# go path
export GOPATH=~/.bin/go

# skim settings
export SKIM_DEFAULT_COMMAND='fd -Ht f'
export SKIM_ALT_C_COMMAND='fd -Ht d'
export SKIM_DEFAULT_OPTS='-m --ansi --bind ctrl-a:toggle-all,ctrl-d:deselect-all,ctrl-t:toggle-all'
export SKIM_DEFAULT_OPTIONS="$SKIM_DEFAULT_OPTS" # TODO make an issue/PR about this difference
export SKIM_COMPLETION_TRIGGER='**'
export SKIM_CTRL_T_COMMAND="$SKIM_DEFAULT_COMMAND"
export SKIM_CTRL_T_OPTS='--preview "bat --color=always --style=numbers --line-range=:500 {}"'
# copy for fzf, incase I ever use it
export FZF_DEFAULT_COMMAND="$SKIM_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$SKIM_ALT_C_COMMAND"
export FZF_DEFAULT_OPTS="$SKIM_DEFAULT_OPTS"
export FZF_COMPLETION_TRIGGER="$SKIM_COMPLETION_TRIGGER"
export FZF_CTRL_T_COMMAND="$SKIM_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="$SKIM_CTRL_T_OPTS"

# dotfile repository location
export DOTREPO="$HOME/git/dotfiles"

# nvim ftw!
export EDITOR=nvim
export PAGER="sed 's/\x1b\[[0-9;]*m//g' | nvim -R"
export AUR_PAGER=$PAGER
export MANPAGER="nvim -c 'set ft=man' -R"

# Use GPG for SSH authentication
export GPG_TTY="$(tty)"

# set SSH_AUTH_SOCK if not logging in over SSH
if [ "$SSH_CONNECTION" -eq "" ]; then
	export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
	gpgconf --launch gpg-agent
fi

# tehfuk
eval $(thefuck --alias)
