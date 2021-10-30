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
set noshowmode                 " Redundant with statusline
set mouse=a                    " Enable mouse

" Indentation and tabs
set expandtab                  " Insert spaces instead of tab characters
set shiftwidth=2               " Indent with 2 spaces
set softtabstop=2              " Nb of spaces inserted with Tab and removed with Backspace
set tabstop=2                  " Witdh of tab characters (when already present)
set autoindent                 " Copy indent from current line when starting a new line
set smartindent                " Smart autoindenting when starting a new line
set formatoptions-=cro         " Stop newline continuation of comments

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use ftplugins instead of autocmds if this gets out of hand
autocmd FileType python setlocal shiftwidth=4 softtabstop=4 tabstop=4
