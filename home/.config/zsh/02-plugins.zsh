# install zplugin if it's not already installed
if [ ! -f ~/.zplugin/bin/zplugin.zsh ]; then
	mkdir ~/.zplugin
	git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin
fi

source ~/.zplugin/bin/zplugin.zsh

# pure prompt
zplugin ice load multisrc'{async,pure}.zsh'
zplugin light sindresorhus/pure

# substring search
zplugin ice lucid
zplugin light zsh-users/zsh-history-substring-search

# omz tab completion etc
zplugin ice lucid
zplugin snippet OMZ::lib/completion.zsh

# fzf git awesomeness
zplugin ice wait'1' lucid atload'source $HOME/.config/zsh/03-functions.zsh'
zplugin light wfxr/forgit

# lots of completions
zplugin ice wait'1' lucid as'completion'
zplugin light zsh-users/zsh-completions

# dotdrop completion
zplugin ice wait'1' lucid as'completion'
zplugin snippet $DOTREPO/dotdrop/completion/_dotdrop-completion.zsh

# docker completion
zplugin ice wait'1' lucid as'completion'
zplugin snippet https://raw.githubusercontent.com/docker/machine/master/contrib/completion/zsh/_docker-machine

# docker-compose completion
zplugin ice wait'1' lucid as'completion'
zplugin snippet https://raw.githubusercontent.com/docker/compose/master/contrib/completion/zsh/_docker-compose

# syntax highlighting
zplugin ice lucid atinit'zpcompinit'
zplugin light zdharma/fast-syntax-highlighting

# use fzf with zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
