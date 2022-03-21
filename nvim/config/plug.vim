" Plugin loader

" Auto-install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'Raimondi/delimitMate'
" delimitMate needs to be loaded before vim-endwise
Plug 'tpope/vim-endwise'
Plug 'mhinz/vim-startify'
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'tomlion/vim-solidity'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'akinsho/toggleterm.nvim'
Plug 'sickill/vim-pasta'
Plug 'ggandor/lightspeed.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'

" Language Servers integration
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp' " Completion engine for built-in LSP
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }

" Formatting & diagnostics
" Plug 'jose-elias-alvarez/null-ls.nvim'

" LSP snippets
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
call plug#end()
