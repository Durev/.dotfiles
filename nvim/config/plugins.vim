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

" --- vim-textobj-rubyblock ---
runtime macros/matchit.vim

" --- vim-commentary ---
autocmd FileType elixir setlocal commentstring=#\ %s

" --- dashboard-nvim ---
let g:indentLine_fileTypeExclude = ['dashboard']
let g:dashboard_default_executive ='telescope'

" fix dashboard overwritting laststatus option (global statusline)
" does not work
" let g:dashboard_disable_statusline = 1
au! bufenter * set laststatus=3

let g:dashboard_custom_section={
  \ 'find_file': { 'description': ['  Find file   '], 'command': 'Telescope find_files' },
  \ 'recent_files': { 'description': ['  Recent files'], 'command': 'Telescope oldfiles' },
  \ 'last_session': { 'description': ['  Last session'], 'command': 'SessionLoad' },
  \ 'find_word': { 'description': ['  Find word   '], 'command': 'Telescope live_grep' },
  \ 'new_file': { 'description': ['  New file    '], 'command': 'enew' },
  \ 'settings': { 'description': ['⚙︎  Dotfiles    '], 'command': 'lcd $DOTFILES | enew' },
\ }

let g:dashboard_custom_header = [
    \ "            .:                :.            ",
    \ "          .---:.              :--.          ",
    \ "        .-----::.             :===-.        ",
    \ "      .----------:            :=====-.      ",
    \ "    .::-----------:           :=======-.    ",
    \ "    ::::------------.         -========:    ",
    \ "    :::::------------:        -========:    ",
    \ "    ::::::------------:       -========:    ",
    \ "    :-------------------.     -========:    ",
    \ "    :--------..----------:    -========:    ",
    \ "    :--------.  -----------   -========:    ",
    \ "    :--------.   :----------. -========:    ",
    \ "    :--------.    .----------:-========:    ",
    \ "    :--------.      ----------=========:    ",
    \ "    :--------.       :--------=========-    ",
    \ "    :--------.        .-------====+++++-    ",
    \ "    :--------.         .------=====++++-    ",
    \ "     :-------.           :----======+=:     ",
    \ "       :-----.            .---======:       ",
    \ "         :-==.             .--====:         ",
    \ "           :-.               -==:  ",
    \ "",
    \ "",
 \]

let g:dashboard_custom_footer = []


" TODO: does not work for toggleterm floating window - find matching setting
" highlight NormalFloat guibg=#455A64
" highlight FloatBorder guifg=white guibg=#34434a
