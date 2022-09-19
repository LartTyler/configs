" Use Ctrl+j instead of Esc
nnoremap <C-j> <Esc>
inoremap <C-j> <Esc>
vnoremap <C-j> <Esc>
snoremap <C-j> <Esc>
xnoremap <C-j> <Esc>
cnoremap <C-j> <C-c>
onoremap <C-j> <Esc>
lnoremap <C-j> <Esc>
tnoremap <C-j> <Esc>

" Ctrl+h to clear search highlighting
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" Suspend with Ctrl+f
inoremap <C-f> :sus<cr>
vnoremap <C-f> :sus<cr>
nnoremap <C-f> :sus<cr>

" Quick actions
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
nmap <leader>ww :xa<CR>
nmap <leader>d :bd<CR>

" Better buffer navigation
map H ^
map L $
nnoremap j gj
nnoremap k gk

" File and buffer navigation
nmap <leader>; :Buffers<CR>
nmap <leader>o :e <C-R>=expand('%:p:h') . "/" <CR>
map <C-p> :Files<CR>
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>
nnoremap <leader><leader> <c-^>

function! s:list_cmd()
	let base = fnamemodify(expand('%'), ':h:.:S')
	return base == '.' ? 'fdfind --type file --follow' : printf('fdfind --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
	\ call fzf#vim#files(<q-args>, {'source': s:list_cmd(), 'options': '--tiebreak=index'}, <bang>0)
