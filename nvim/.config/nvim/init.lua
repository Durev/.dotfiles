-- init.lua

-- set runtimepath^=~/.vim runtimepath+=~/.vim/after
-- let &packpath = &runtimepath

vim.cmd [[source ~/.config/nvim/options.vim]]     -- General settings

require("config.lazy")

vim.cmd [[source ~/.config/nvim/colorscheme.vim]] -- Colorscheme
vim.cmd [[source ~/.config/nvim/plugins.vim]]     -- Plugins specific settings (vim script)
vim.cmd [[source ~/.config/nvim/plugins.lua]]     -- Plugins specific settings (lua)
vim.cmd [[source ~/.config/nvim/cmp.lua]]         -- Completion
vim.cmd [[source ~/.config/nvim/lsp.lua]]         -- Language servers configuration
vim.cmd [[source ~/.config/nvim/mappings.lua]]    -- Key mappings

-- require("plugins")
-- require("cmp")
-- require("lsp")
-- require("mappings")
