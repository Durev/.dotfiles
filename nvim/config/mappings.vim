" Key mappings

" ======= General Mappings =======
" Leader key
let mapleader = "\<Space>"

" Always jump to first non blank character
nmap 0 ^

" Write the file with Ctrl-s
nmap <C-s> :w<cr>
imap <C-s> <esc>:w<cr>

" Move up and down by visible lines if current line is wrapped
nmap j gj
nmap k gk

" Rapid editing of vimrc
nmap <leader>vr :tabnew $MYVIMRC<cr>
nmap <leader>so :source $MYVIMRC<cr>

" Ain't nobody got time for Esc
imap jk <esc>
imap kj <esc>

" Jump to left/right split
nmap <leader><Left> <C-w>h
nmap <leader><Right> <C-w>l

" Ruby motion
nmap <leader>d [m
nmap <leader>e ]M
nmap <leader>E [M
nmap <leader>D ]m

" ======= Plugins =======
" --- fzf ---
nnoremap <C-p> :Files<cr>
nnoremap <leader>ff :Ag<cr>

" --- RSpec.vim - save and run specs ---
map <Leader>t :w<cr> :call RunCurrentSpecFile()<cr>
map <Leader>s :w<cr> :call RunNearestSpec()<cr>
map <Leader>l :w<cr> :call RunLastSpec()<cr>

" --- gitgutter ---
nmap <leader>hn <Plug>(GitGutterNextHunk)
nmap <leader>hl <Plug>(GitGutterPrevHunk)

" --- NERDTree ---
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <silent><leader>ntf :NERDTreeFind<CR>
