set updatetime=500

set pyxversion=3

set mouse=a

set numberwidth=1

set norelativenumber

set clipboard=unnamed

set autoread

set nocompatible
syntax enable
set showcmd
filetype plugin indent on

set nowrap
set tabstop=2 shiftwidth=2
set expandtab
set backspace=indent,eol,start
set autoindent

set hlsearch
set incsearch
set ignorecase
set smartcase

set number
set ruler

set showmatch

set encoding=utf-8

set autowrite

set list
set listchars=tab:\|\ ,trail:▫,extends:>,precedes:<,nbsp:+

" Javascript
autocmd BufRead *.js set filetype=javascript
autocmd BufRead *.jsx set filetype=javascript
augroup filetype javascript syntax=javascript

augroup filetype markdown syntax=markdown

set undofile
set undodir=~/.vim/undo

set signcolumn=yes

set cursorline

set laststatus=2
set noshowmode

set conceallevel=2

set splitright

set timeoutlen=500
