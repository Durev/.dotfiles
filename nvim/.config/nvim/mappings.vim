" Key mappings

" :verbose map / :verbose nnoremap / :verbose vnoremap / :verbose inoremap ...

" Mapping versions
"   recursive = map
"   non-recursive = noremap

" Modes
"   normal mode = n
"   insert mode = i
"   visual mode = v
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

" TODO: To improve
function! Quit()
  if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    :q
  else
    :bdelete
  endif
endfunction
nnoremap Q :call Quit()<cr>

" New split
nnoremap vv <C-w>v
" nnoremap ss <C-w>s
" 'conflict' with lightspeed s default mapping

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

" Beginning/end of paragraph
nnoremap <up> {
nnoremap <down> }

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

" Jump to last non-whitespace character
vnoremap $ g_

" Beginning/end of paragraph
vnoremap <up> {
vnoremap <down> }

" Keep yanked text on top of register after pasting
" vnoremap p _dP

" ========== Plugins ==========
" --- telescope ---
nnoremap <C-p> <cmd>Telescope find_files hidden=true<cr>
nnoremap <leader>ff <cmd>Telescope live_grep<cr>
nnoremap <leader>fs <cmd>Telescope grep_string<cr>
nnoremap <leader>fr <cmd>Telescope lsp_references show_line=false<cr>
nnoremap <leader>fd <cmd>Telescope lsp_definitions<cr>
nnoremap <leader>flsd <cmd>Telescope diagnostics<cr>
nnoremap <leader>fgc <cmd>Telescope git_commits<cr>
nnoremap <leader>fgb <cmd>Telescope git_branches<cr>
nnoremap <leader>fgst <cmd>Telescope git_status<cr>

" --- test.vim - save and run specs ---
nnoremap <Leader>t :w<cr> :TestFile<cr>
nnoremap <Leader>s :w<cr> :TestNearest<cr>
nnoremap <Leader>l :w<cr> :TestLast<cr>

" --- nvim-tree ---
nnoremap <silent><leader>nt :NvimTreeToggle<CR>
nnoremap <silent><leader>nf :NvimTreeFindFile<CR>

" ========== LSP ==========
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>dp <cmd>lua vim.diagnostic.open_float()<CR>
nnoremap <silent> <leader>dl <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> <leader>dn <cmd>lua vim.diagnostic.goto_next()<CR>

" not implemented yet
" nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>