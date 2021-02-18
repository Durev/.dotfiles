# Path to your dotfiles
export DOTFILES=$HOME/.dotfiles

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# Using https://github.com/denysdovhan/spaceship-prompt
ZSH_THEME="spaceship"
SPACESHIP_GIT_STATUS_COLOR="172"

# Use case-sensitive completion
CASE_SENSITIVE="true"

# Command execution timestamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=$DOTFILES

# Oh My Zsh plugins
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(bundler colorize git git-flow rails rake-fast rbenv sublime)

source $ZSH/oh-my-zsh.sh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

######################## Not sure if useful #########################

# Load rbenv automatically
# eval "$(rbenv init -)"


# PROJECT_PATHS=(~/Dev)

