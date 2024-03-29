" Plugin loader

" Auto-install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'Raimondi/delimitMate' " needs to be loaded before vim-endwise
Plug 'tpope/vim-endwise'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'tomlion/vim-solidity'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'sickill/vim-pasta'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'max397574/better-escape.nvim'
Plug 'nvim-tree/nvim-web-devicons', { 'tag': 'nerd-v2-compat' }
Plug 'nvim-tree/nvim-tree.lua'
Plug 'vim-test/vim-test'
Plug 'lukas-reineke/indent-blankline.nvim', { 'commit': '9637670' } " TODO: Unpin and finish v3 update
Plug 'nvim-telescope/telescope.nvim'
Plug 'glepnir/dashboard-nvim', { 'commit': 'bd7163f56ac715a6d687737ea144731ac6ce8478' } " TODO: Unpin or change plugin
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
Plug 'elixir-editors/vim-elixir'
Plug 'akinsho/git-conflict.nvim', { 'tag': '*' }
Plug 'Pocco81/true-zen.nvim'
Plug 'RRethy/vim-illuminate'
Plug 'folke/which-key.nvim'
Plug 'wellle/targets.vim'
Plug 'sindrets/diffview.nvim'
Plug 'ggandor/leap.nvim'
Plug 'ggandor/flit.nvim'
Plug 'gorbit99/codewindow.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'j-hui/fidget.nvim', { 'tag': 'legacy' } " Pin to avoid breaking changes at rewrite
Plug 'mechatroner/rainbow_csv'
Plug 'mbbill/undotree'
Plug 'rcarriga/nvim-notify' " used by ror
Plug 'stevearc/dressing.nvim' " used by ror
Plug 'weizheheng/ror.nvim'
Plug 'ThePrimeagen/git-worktree.nvim'

" Custom text objects
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'

" LSP, completion & AI stuff
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua' " source for neovim lua API
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'zbirenbaum/copilot.lua' " using lua rewrite
Plug 'zbirenbaum/copilot-cmp' " so I can plug it to cmp

" Snippets
Plug 'L3MON4D3/LuaSnip', {'tag': 'v1.*'}
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'
call plug#end()
