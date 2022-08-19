" Plugins settings

" --- fzf ---
" Ignore filenames in Ag matching
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

" --- test.vim---
let test#strategy = "dispatch"
let g:dispatch_compilers = {'elixir': 'exunit'}

" --- nvim-tree ---
" Close the tab if nvim-tree is the last window remaining
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif

" --- delimitMate ---
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

" Fix: https://github.com/tpope/vim-endwise/issues/133
if empty(maparg('<CR>', 'i'))
  imap <CR> <Plug>delimitMateCR
endif

" --- vim-textobj-rubyblock ---
runtime macros/matchit.vim

" --- vim-commentary ---
autocmd FileType elixir setlocal commentstring=#\ %s

" --- dashboard-nvim ---
" fix dashboard overwritting laststatus option (global statusline)
au! bufenter * set laststatus=3

" TODO: does not work for toggleterm floating window - find matching setting
" highlight NormalFloat guibg=#455A64
" highlight FloatBorder guifg=white guibg=#34434a
