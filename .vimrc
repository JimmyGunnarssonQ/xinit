" Calling plugins.
call plug#begin()
	Plug 'junegunn/goyo.vim'
	Plug 'preservim/NERDTree'
	Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
	Plug 'Valloric/YouCompleteMe'
	Plug 'itchyny/lightline.vim'
	Plug 'lervag/vimtex'
	Plug 'vim-airline/vim-airline'
call plug#end()

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
map <F2> :NERDTreeToggle <CR>
" some helpers. 
set wrap
filetype on
set history=1000
set langmenu=en_US
let $LANG='en_US'
set encoding=utf8
set softtabstop=2
set autoindent
filetype plugin indent on
set nu!
set noswapfile 
set hlsearch 
set ignorecase 
set incsearch 
set laststatus=2
set linebreak 
syntax on 
set linebreak
set syntax=context
set showcmd 
set visualbell 
set wildmenu 
set history=1000
set shellcmdflag=-ic
augroup filetype_vim
	autocmd! 
	autocmd FileType vim setlocal foldmethod=marker
augroup END
