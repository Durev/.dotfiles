" Key mappings

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
nmap <C-s> :w<cr>
imap <C-s> <esc>:w<cr>
vmap <C-s> <esc>:w<cr>

" Move text up and down
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" ------ Normal ------
" Always jump to first non blank character
nmap 0 ^

" Move up and down by visible lines if current line is wrapped
nmap j gj
nmap k gk

" Rapid editing of init.vim
nmap <leader>vr :tabnew $MYVIMRC<cr>
nmap <leader>so :source $MYVIMRC<cr>

" Easy quit
nmap Q :q<cr>

" New split
nmap vv <C-w>v
nmap ss <C-w>s

" Jump to split
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

" Resize split with arrows
nmap <M-Up> :resize +2<cr>
nmap <M-Down> :resize -2<cr>
nmap <M-Left> :vertical resize -2<cr>
nmap <M-Right> :vertical resize +2<cr>

" Switch tab
nmap <right> gt
nmap <left> gT

" Ruby motion
nmap <leader>d [m
nmap <leader>e ]M
nmap <leader>E [M
nmap <leader>D ]m

" ------ Insert ------
" Ain't nobody got time for Esc
imap jk <esc>
imap kj <esc>

" End / Beginning of line in insert mode
imap ¬ <esc>$a
imap Ì <esc>0i

" ------ Visual ------
" Stay in indent mode
vmap > >gv
vmap < <gv

" Keep yanked text on top of register after pasting
" vmap p _dP

" ========== Plugins ==========
" --- fzf ---
nmap <C-p> :Files<cr>
nmap <leader>ff :Ag<cr>

" --- RSpec.vim - save and run specs ---
nmap <Leader>t :w<cr> :call RunCurrentSpecFile()<cr>
nmap <Leader>s :w<cr> :call RunNearestSpec()<cr>
nmap <Leader>l :w<cr> :call RunLastSpec()<cr>

" --- gitgutter ---
nmap <leader>hn <Plug>(GitGutterNextHunk)
nmap <leader>hl <Plug>(GitGutterPrevHunk)
nmap <leader>hs <Plug>(GitGutterStageHunk)

" --- NERDTree ---
nmap <leader>ntt :NERDTreeToggle<CR>
nmap <silent><leader>ntf :NERDTreeFind<CR>
