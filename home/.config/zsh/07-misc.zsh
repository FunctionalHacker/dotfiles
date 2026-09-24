# share history between running zsh instances
setopt share_history

# ignore commands with leading space from history
setopt histignorespace

# Enable going backwards in history
setopt no_flow_control

# Fix error on Termux https://github.com/jeffreytse/zsh-vi-mode/issues/159#issuecomment-1871335866
setopt re_match_pcre
