" Calling plugins.
call plug#begin("$HOME/.vim/plugged")
	Plug 'junegunn/goyo.vim'
	Plug 'preservim/NERDTree'
	Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
	Plug 'Valloric/YouCompleteMe'
	Plug 'itchyny/lightline.vim'
	Plug 'vimwiki/vimwiki'
	Plug 'lervag/vimtex'
	Plug 'vim-airline/vim-airline'
	Plug 'kien/ctrlp.vim'
	Plug 'liuchengxu/space-vim-dark'
call plug#end()
"""Plugin related
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let mapleader=" "
map <F2> :NERDTreeToggle<CR>
map <leader>f :Goyo \| set linebreak<CR>
map <leader>o: setlocal spell! spelllang=en_US<CR>
map <leader>s :!clear && shellcheck %<CR>
inoremap jf <esc>
"" Ease of writing 
set wrap
filetype on
set history=1000
"""Writing style
set langmenu=en_US
let $LANG='en_US'
set encoding=utf8
set softtabstop=2
set autoindent
syntax on
set syntax=context
filetype plugin indent on "for YCM
set number relativenumber
""""No backups 
set noswapfile 
set nobackup 
set nowritebackup
"""Search helpers
set hlsearch 
set ignorecase 
set smartcase
set incsearch 
set laststatus=2
set linebreak 
set gdefault 
set showmode 
set showmatch 
"""Cursor 
set cursorline 
set cursorcolumn
"""Others 
set nocompatible
set virtualedit+=block
set showcmd 
set history=1000
set shellcmdflag=-ic
"""Menus 
set wildmenu 
set wildmode=list:longest 

augroup filetype_vim
	autocmd! 
	autocmd FileType vim setlocal foldmethod=marker
augroup END
colorscheme space-vim-dark
set termguicolors
hi LineNr ctermbg=NONE guibg=NONE
