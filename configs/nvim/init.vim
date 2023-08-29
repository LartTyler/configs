set shell=/bin/bash
let mapleader = "\<Space>"

call plug#begin()
" Baseline
Plug 'tpope/vim-sensible'

" Libraries
Plug 'nvim-lua/plenary.nvim'

" GUI improvements
Plug 'itchyny/lightline.vim'
Plug 'andymass/vim-matchup'
Plug 'j-hui/fidget.nvim', { 'tag': 'legacy' }

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Language tools
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Languages
Plug 'cespare/vim-toml', { 'branch': 'main' }
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'simrat39/rust-tools.nvim'
Plug 'dag/vim-fish'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'junegunn/limelight.vim', { 'for': 'markdown' }
Plug 'saecki/crates.nvim', { 'tag': 'v0.3.0' }
Plug 'mracos/mermaid.vim'

" Color scheme
Plug 'sickill/vim-monokai', { 'as': 'monokai' }
Plug 'NLKNguyen/papercolor-theme'
call plug#end()

" Run Lua configurations
lua << EOF
require('entrypoint')
EOF

let g:PaperColor_Theme_Options = { 'theme': { 'default': { 'transparent_background': 1 } } }
colorscheme PaperColor
hi SignColumn ctermbg=none
let g:lightline = { 'colorscheme': 'PaperColor' }

" hrsh7th/nvim-cmp settings
set completeopt=menu,menuone,noselect
set cmdheight=2
set updatetime=300

" Rust stuff
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'

" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Extra configs
runtime editor.vim
runtime gui.vim
runtime keybindings.vim
