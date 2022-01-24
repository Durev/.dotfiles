" Key mappings

" :verbose map / :verbose nnoremap / :verbose vnoremap / :verbose inoremap ...

" Mapping versions
"   recursive = map
"   non-recursive = noremap

" Modes
"   normal mode = n
"   visual mode = i
"   visual block mode = x
"   term mode = t
"   command mode = c

" ========== General Mappings ==========
" Leader key
let mapleader = "\<Space>"

" Write the file with Ctrl-s
nnoremap <C-s> :w<cr>
inoremap <C-s> <esc>:w<cr>
vnoremap <C-s> <esc>:w<cr>

" Move text up and down
" With French Keyboard, the OS remaps <M-j> to Ï and <M-k> to È
nnoremap Ï :m .+1<CR>==
nnoremap È :m .-2<CR>==
vnoremap Ï :m '>+1<CR>gv=gv
vnoremap È :m '<-2<CR>gv=gv
inoremap Ï <Esc>:m .+1<CR>==gi
inoremap È <Esc>:m .-2<CR>==gi

" ------ Normal ------
" Always jump to first non blank character
nnoremap 0 ^

" Move up and down by visible lines if current line is wrapped
nnoremap j gj
nnoremap k gk

" Rapid editing of init.vim
nnoremap <leader>vr :tabnew $MYVIMRC<cr>
nnoremap <leader>so :source $MYVIMRC<cr>

" Easy quit
nnoremap Q :q<cr>

" New split
nnoremap vv <C-w>v
nnoremap ss <C-w>s

" Jump to split
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Resize split with arrows
nnoremap <M-Up> :resize +2<cr>
nnoremap <M-Down> :resize -2<cr>
nnoremap <M-Left> :vertical resize -2<cr>
nnoremap <M-Right> :vertical resize +2<cr>

" Switch tab
nnoremap <right> gt
nnoremap <left> gT

" Ruby motion
nnoremap <leader>d [m
nnoremap <leader>e ]M
nnoremap <leader>E [M
nnoremap <leader>D ]m

" ------ Insert ------
" Ain't nobody got time for Esc
inoremap jk <esc>
inoremap kj <esc>

" End / Beginning of line in insert mode
inoremap ¬ <esc>$a
inoremap Ì <esc>0i

" ------ Visual ------
" Stay in indent mode
vnoremap > >gv
vnoremap < <gv

" Keep yanked text on top of register after pasting
" vnoremap p _dP

" ========== Plugins ==========
" --- fzf ---
nnoremap <C-p> :Files<cr>
nnoremap <leader>ff :Ag<cr>

" --- RSpec.vim - save and run specs ---
nnoremap <Leader>t :w<cr> :call RunCurrentSpecFile()<cr>
nnoremap <Leader>s :w<cr> :call RunNearestSpec()<cr>
nnoremap <Leader>l :w<cr> :call RunLastSpec()<cr>

" --- gitgutter ---
nnoremap <leader>hn <Plug>(GitGutterNextHunk)
nnoremap <leader>hl <Plug>(GitGutterPrevHunk)
nnoremap <leader>hs <Plug>(GitGutterStageHunk)

" --- NERDTree ---
nnoremap <leader>ntt :NERDTreeToggle<CR>
nnoremap <silent><leader>ntf :NERDTreeFind<CR>
