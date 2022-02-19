" init.vim

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source $HOME/.dotfiles/nvim/config/options.vim     " General settings
source $HOME/.dotfiles/nvim/config/mappings.vim    " Key mappings
source $HOME/.dotfiles/nvim/config/plug.vim        " Plugin loader
source $HOME/.dotfiles/nvim/config/plugins.vim     " Plugins specific settings (vim script) & colorscheme
source $HOME/.dotfiles/nvim/config/plugins.lua     " Plugins specific settings (lua)
source $HOME/.dotfiles/nvim/config/lsp-config.lua  " Language servers configuration
