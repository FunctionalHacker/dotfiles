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

# Enable completions for aliases
setopt no_complete_aliases

# Variable to pass to sdotdrop to get current user
export USRNAME=$USER

# Add ~/.bin to path
export PATH="/home/$USER/.bin:$PATH"

# go path
export GOPATH=~/.go

# fzf settings
export FD_COMMAND='fd -HLt'
export FZF_DEFAULT_COMMAND="$FD_COMMAND f"
export FZF_ALT_C_COMMAND="$FD_COMMAND d"
export FZF_DEFAULT_OPTS='-m --ansi --bind ctrl-a:toggle-all,ctrl-d:deselect-all,ctrl-t:toggle-all'
export FZF_COMPLETION_TRIGGER='**'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=numbers --line-range=:500 {}"'
_fzf_compgen_path() {
	resultcmd="$FZF_DEFAULT_COMMAND . $1"
	eval ${resultcmd}
}
_fzf_compgen_dir() {
	resultcmd="$FZF_ALT_C_COMMAND . $1"
	eval ${resultcmd}
}

# dotfile repository location
export DOTREPO="$HOME/git/dotfiles"

# nvim ftw!
export EDITOR=nvim
export PAGER="$EDITOR -R +\"lua require 'pager'\""
export GIT_PAGER="$EDITOR -c 'set ft=git' -R +\"lua require 'pager'\""
export PARU_PAGER="$PAGER -c 'set ft=PKGBUILD'"
export AUR_PAGER=$EDITOR
export MANPAGER="$EDITOR +\"lua require 'pager'\" +Man!"
export SYSTEMD_EDITOR=$EDITOR
export SYSTEMD_PAGER=less

{%@@ if os == "arch" or os == "ubuntu" @@%}
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
gpgconf --launch gpg-agent
{%@@ elif os == "termux" @@%}
eval $(okc-ssh-agent)
{%@@ endif @@%}

# Enable grc colorization of supported commands
[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh

# Disable dotdrop submodule auto update
export DOTDROP_AUTOUPDATE=no