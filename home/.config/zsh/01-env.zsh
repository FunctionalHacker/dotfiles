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
export FZF_DEFAULT_COMMAND='fd -Ht f'
export FZF_ALT_C_COMMAND='fd -Ht d'
export FZF_DEFAULT_OPTS='-m --ansi --bind ctrl-a:toggle-all,ctrl-d:deselect-all,ctrl-t:toggle-all'
export FZF_COMPLETION_TRIGGER='**'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=numbers --line-range=:500 {}"'
_fzf_compgen_dir() {
    fd -Ht d
}
_fzf_compgen_path() {
    fd -Ht f
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

# Use GPG for SSH authentication
export GPG_TTY="$(tty)"

{%@@ if os == "arch" @@%}
# set SSH_AUTH_SOCK if not logging in over SSH
if [ "$SSH_CONNECTION" = "" ]; then
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    #gpgconf --launch gpg-agent
    gpg-connect-agent updatestartuptty /bye >/dev/null
fi
{%@@ elif os == "termux" @@%}
if ! pgrep okc-ssh-agent > /dev/null; then
	okc-ssh-agent > "$PREFIX/tmp/okc-ssh-agent.env"
fi
{%@@ endif @@%}

# Enable grc colorization of supported commands
[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh

# Disable dotdrop submodule auto update
export DOTDROP_AUTOUPDATE=no
