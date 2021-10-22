" Plugins settings

" --- fzf ---
" Ignore filenames in Ag matching
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

" --- RSpec.vim ---
let g:rspec_runner = "os_x_iterm2"
let g:rspec_command = "Dispatch rspec {spec}"

" --- NERDTree ---
" Open NERDTree when Vim is started without file arguments - disable startify though
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" --- startify ---
let g:startify_lists = [
    \{ 'type': 'dir',       'header': ['   MRU '. getcwd()] },
    \{ 'type': 'sessions',  'header': ['   Sessions']       },
    \{ 'type': 'bookmarks', 'header': ['   Bookmarks']      },
\]

" from https://github.com/filipekiss/dotfiles/blob/7ddece0a1a4e5099146d7c96fff077c86e4d320a/config/vim/.vim/after/plugin/startify.vim
if has('nvim')
    let g:startify_ascii = [
                \ "      .            .      ",
                \ "    .,;'           :,.    ",
                \ "  .,;;;,,.         ccc;.  ",
                \ ".;c::::,,,'        ccccc: ",
                \ ".::cc::,,,,,.      cccccc.",
                \ ".cccccc;;;;;;'     llllll.",
                \ ".cccccc.,;;;;;;.   llllll.",
                \ ".cccccc  ';;;;;;'  oooooo.",
                \ "'lllllc   .;;;;;;;.oooooo'",
                \ "'lllllc     ,::::::looooo'",
                \ "'llllll      .:::::lloddd'",
                \ ".looool       .;::coooodo.",
                \ "  .cool         'ccoooc.  ",
                \ "    .co          .:o:.    ",
                \ "      .           .'      ",
                \]
else
    let g:startify_ascii = [
                \ '     ________ ;;     ________',
                \ '    /********\;;;;  /********\',
                \ '    \********/;;;;;;\********/',
                \ '     |******|;;;;;;;;/*****/',
                \ '     |******|;;;;;;/*****/''',
                \ '    ;|******|;;;;/*****/'';',
                \ '  ;;;|******|;;/*****/'';;;;;',
                \ ';;;;;|******|/*****/'';;;;;;;;;',
                \ '  ;;;|***********/'';;;;;;;;;',
                \ '    ;|*********/'';;;;;;;;;',
                \ '     |*******/'';;;;;;;;;',
                \ '     |*****/'';;;;;;;;;',
                \ '     |***/'';;;;;;;;;',
                \ '     |*/''   ;;;;;;',
                \ '              ;;',
                \]
endif

let g:startify_custom_header = g:startify_ascii

let g:startify_bookmarks = [
    \{ 'd': '$DOTFILES' },
    \{ 's': '$SSERVER' },
    \{ 'l': '$SETL' },
\]

" ======= Color scheme & Statusline =======
if (has('termguicolors'))
    set termguicolors
endif

" default lightline colorscheme provide greater contrast - Stay minimal for now
let g:lightline = {
    \ 'colorscheme': 'material_vim',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead'
    \ },
    \ }

" Fix italics in Vim
if !has('nvim')
  let &t_ZH="\e[3m"
  let &t_ZR="\e[23m"
endif

let g:material_terminal_italics = 1
let g:material_theme_style = 'default'

colorscheme material

" gitgutter colors
highlight GitGutterDelete guifg=#E74C3C
highlight GitGutterChange guifg=#F1C40F
highlight GitGutterAdd guifg=#27AE60
highlight clear SignColumn
