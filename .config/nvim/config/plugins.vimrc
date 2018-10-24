call plug#begin()

" syntax
Plug 'sheerun/vim-polyglot'
Plug 'ianks/vim-tsx'

" javascript
Plug 'flowtype/vim-flow'

" status bar
Plug 'maximbaz/lightline-ale'
Plug 'itchyny/lightline.vim'

" themes
Plug 'jacoborus/tender.vim'
Plug 'yarisgutierrez/ayu-lightline'
Plug 'ayu-theme/ayu-vim'

" tree
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-scripts/vim-webdevicons'

" typing
Plug 'mattn/emmet-vim'
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

" tmux
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'

" autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins' }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install -g tern' }
Plug 'carlitux/deoplete-ternjs'

" test
Plug 'tyewang/vimux-jest-test'
Plug 'janko-m/vim-test'

" IDE
Plug 'w0rp/ale'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-signify'
Plug 'yggdroot/indentline'
Plug 'scrooloose/nerdcommenter'

" additional
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'

call plug#end()
