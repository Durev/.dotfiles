" init.vim

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source $HOME/.dotfiles/nvim/config/options.vim " general settings
source $HOME/.dotfiles/nvim/config/mappings.vim " key mappings
source $HOME/.dotfiles/nvim/config/plug.vim     " plugin loader
source $HOME/.dotfiles/nvim/config/plugins.vim  " plugins specific settings (vim script) & colorscheme
source $HOME/.dotfiles/nvim/config/plugins.lua  " plugins specific settings (lua)
