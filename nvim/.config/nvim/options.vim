" General settings
" :help options

set nocompatible               " No need for vi compatibility - Must be setup first

syntax on                      " Enable syntax highlighting
filetype on                    " Enable filetype detection
filetype indent on             " Enable filetype-specific indenting
filetype plugin on             " Enable filetype-specific plugins

set hidden
set number relativenumber      " Hybride mode for line numbers
set backspace=indent,eol,start " Allow backspacing over everything in insert mode
set ruler                      " Show the cursor position all the time
set cursorline                 " Highlight cursorline
set splitbelow                 " Open new split panes to bottom
set splitright                 " Open new split panes to right
set directory=$HOME/.vim/tmp   " Don't clutter dirs up with swp and tmp files
set updatetime=100             " Refresh gutter and whatnot every 100ms
set nohlsearch                 " Don't keep search result highlighted
set noshowmode                 " Redundant with statusline
set mouse=a                    " Enable mouse
set clipboard+=unnamedplus     " Always use the system clipboard
set signcolumn=yes             " Always show the sign column to avoid visual jumps
set ignorecase                 " Case insensitive search
set smartcase                  " Case sensitive search if the search pattern contains uppercase characters
" set nowrap                     " Display lines as one long line
set scrolloff=5                " Min nb of lines above and below the cursor
set laststatus=3               " Use NeoVim Global Status line (v 0.7)
set pumheight=10               " Max nb of items in floating window (cmp...)

" Indentation and tabs
set expandtab                  " Insert spaces instead of tab characters
set shiftwidth=2               " Indent with 2 spaces
set softtabstop=2              " Nb of spaces inserted with Tab and removed with Backspace
set tabstop=2                  " Witdh of tab characters (when already present)
set autoindent                 " Copy indent from current line when starting a new line
set smartindent                " Smart autoindenting when starting a new line

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Stop newline continuation of comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Switch to absolute numbers in insert mode or when losing focus
" From https://jeffkreeftmeijer.com/vim-number/
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" Use ftplugins instead of autocmds if this gets out of hand
autocmd FileType python setlocal shiftwidth=4 softtabstop=4 tabstop=4
autocmd FileType go setlocal shiftwidth=4 softtabstop=4 tabstop=4 noexpandtab
autocmd BufNewFile,BufRead Brewfile,.Brewfile set filetype=ruby

" Highlight on yank (:h lua-highlight)
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=220}
