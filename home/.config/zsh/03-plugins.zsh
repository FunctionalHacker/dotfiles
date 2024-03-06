# install zinit if it's not already installed
if [ ! -f ~/.zinit/bin/zinit.zsh ]; then
  mkdir ~/.zinit
  git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
fi

source ~/.zinit/bin/zinit.zsh

# pure prompt
zinit ice load multisrc'{async,pure}.zsh'
zinit light sindresorhus/pure

# fzf as tab completion
zinit ice lucid
zinit light Aloxaf/fzf-tab

# substring search
zinit ice lucid
zinit light zsh-users/zsh-history-substring-search

# fzf git awesomeness
zinit ice wait'1' lucid atload'source $HOME/.config/zsh/04-aliases.zsh'
zinit light wfxr/forgit

# lots of completions
zinit ice wait'1' lucid as'completion'
zinit light zsh-users/zsh-completions

# swaymsg completions
zinit ice wait'1' lucid as'completion'
zinit snippet https://gist.githubusercontent.com/RPigott/a3efdc08fa4d5fd7df38d091ab5e8532/raw/867ac1884d97d1bd1e5d4037d4eefdf4a004e72b/_swaymsg

# syntax highlighting
zinit ice lucid atinit'zpcompinit'
zinit light zdharma-continuum/fast-syntax-highlighting

# use fzf with zsh
{%@@ if distro_id == "termux" @@%}
source $PREFIX/share/fzf/key-bindings.zsh
source $PREFIX/share/fzf/completion.zsh
{%@@ elif distro_id == "debian" @@%}
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
{%@@ else @@%}
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
{%@@ endif @@%}

{%@@ if distro_id != "termux" @@%}
# enable https://github.com/nvbn/thefuck
eval $(TF_SHELL=zsh thefuck --alias)
{%@@ endif @@%}

# Generate completions at runtime
zinit ice wait'2' lucid
zinit light RobSis/zsh-completion-generator
