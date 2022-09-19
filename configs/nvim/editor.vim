set signcolumn=yes
set noshowmode
set nowrap
set scrolloff=15
set clipboard+=unnamedplus

" FZF settings
let g:fzf_layout = { 'down': '~40%' }

" Wrapping
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments after pressing ENTER
set formatoptions+=q " enable comment formatting
set formatoptions+=n " detect lists
set formatoptions+=b " auto-wrap while typing

" More lenient search
set incsearch
set ignorecase
set smartcase
set gdefault

" Center search results
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Persistent undo
set undodir=~/.vimdid
set undofile

" Better wildmenu
set wildmenu
set wildmode=list:longest

" Use compact tabs
set shiftwidth=4
set tabstop=4
set softtabstop=4
set noexpandtab

" Better split behavior
set splitright
set splitbelow
