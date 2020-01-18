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
export FZF_DEFAULT_COMMAND='rg --files --hidden 2>/dev/null'
export FZF_COMPLETION_TRIGGER='**'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "/usr/bin/cat {} | nvimpager -c "'
export FZF_ALT_C_COMMAND='rg --hidden --files --null --sort path 2>/dev/null | xargs -0 dirname | uniq'

# use lesspipe with less
export LESSOPEN="|lesspipe.sh %s"

# dotdrop repository location
export DOTREPO="$HOME/Git/dotfiles"

# nvim ftw!
export EDITOR=nvim
export PAGER="nvimpager -p"

{%@@ if profile == "Mirkwood" @@%}
# use gpg for ssh
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
gpg-connect-agent updatestartuptty /bye > /dev/null
{%@@ endif @@%}

# tehfuk
eval $(thefuck --alias)
