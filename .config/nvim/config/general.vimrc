set mouse=a

set numberwidth=1

set relativenumber

set clipboard=unnamed

set autoread

set nocompatible                " choose no compatibility with legacy vi
syntax enable
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces
set expandtab                   " use spaces, not tabs
set backspace=indent,eol,start  " backspace through everything in insert mode
set autoindent

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

set number
set ruler

set showmatch

set encoding=utf-8

set autowrite

set list                                                     " show trailing whitespace
set listchars=space:·,tab:▸\ ,trail:▫,extends:>,precedes:<,nbsp:+,eol:¬

" Javascript
autocmd BufRead *.js set filetype=javascript
autocmd BufRead *.jsx set filetype=javascript
augroup filetype javascript syntax=javascript

" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.vim/undo

set signcolumn=yes

set cursorline

set laststatus=2                                                "always display status line
set noshowmode                                                  "dont show --INSERT--

" override tmux maps
