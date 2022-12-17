" init.vim

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source ~/.config/nvim/options.vim     " General settings
source ~/.config/nvim/plug.vim        " Plugin loader
source ~/.config/nvim/colorscheme.vim " Colorscheme
source ~/.config/nvim/plugins.vim     " Plugins specific settings (vim script)
source ~/.config/nvim/plugins.lua     " Plugins specific settings (lua)
source ~/.config/nvim/cmp.lua         " Completion
source ~/.config/nvim/lsp.lua         " Language servers configuration
source ~/.config/nvim/mappings.lua    " Key mappings
