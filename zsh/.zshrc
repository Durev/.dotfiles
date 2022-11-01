#          _
#  _______| |__  _ __ ___
# |_  / __| '_ \| '__/ __|
#  / /\__ \ | | | | | (__
# /___|___/_| |_|_|  \___|

export DOTFILES=$HOME/.dotfiles
export ZDOTDIR=$DOTFILES/zsh

# source other files (exports, functions, etc.)
for config (~/.zsh/*.zsh) source $config

# ------- Plugins -------
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ------- Settings & Options -------
# Disable flow control commands (keeps C-s from freezing everything)
stty start undef
stty stop undef

# Disable auto-highlight of pasted content
zle_highlight=('paste:none')

# Do not find duplicate command when searching in history
setopt HIST_FIND_NO_DUPS

# rbenv
eval "$(rbenv init -)"

# Keep cycling through history with autosuggestions on
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# NVM
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
