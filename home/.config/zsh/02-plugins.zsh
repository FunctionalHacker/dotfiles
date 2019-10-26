# install zplugin if it's not
if [ ! -f ~/.zplugin/bin/zplugin.zsh ]; then
	mkdir ~/.zplugin
	git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin
fi

source ~/.zplugin/bin/zplugin.zsh

# pure prompt
zplugin ice lucid pick'async.zsh' src'pure.zsh' onlight'prompt_pure_setup'
zplugin light sindresorhus/pure

# substring search
zplugin ice wait'1' lucid
zplugin light zsh-users/zsh-history-substring-search

zplugin ice wait'1' lucid
zplugin snippet OMZ::lib/completion.zsh

# fzf git awesomeness
zplugin ice wait'1' lucid atload'source $HOME/.config/zsh/03-functions.zsh'
zplugin light wfxr/forgit

# dotdrop completion
zplugin ice wait'1' lucid as'completion'
zplugin snippet $DOTREPO/dotdrop/completion/_dotdrop-completion.zsh

# syntax highlighting
zplugin ice wait'1' lucid atinit'zpcompinit'
zplugin light zdharma/fast-syntax-highlighting

# use fzf with zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
