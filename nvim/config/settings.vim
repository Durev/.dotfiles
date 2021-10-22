" General settings

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
set expandtab                  " On pressing tab, insert spaces
set shiftwidth=4               " Indent with 4 spaces (if no language rule)
set autoindent                 " Copy indent from current line when starting a new line
set smartindent                " Smart autoindenting when starting a new line
set noshowmode                 " Redundant with statusline
set formatoptions-=cro         " Stop newline continution of comments
set mouse=a                    " Enable mouse

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·
