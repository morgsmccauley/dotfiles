call plug#begin()

" status bar
Plug 'maximbaz/lightline-ale'
Plug 'itchyny/lightline.vim'

" javascript
Plug 'pangloss/vim-javascript'
Plug 'isruslan/vim-es6'
Plug 'mxw/vim-jsx'
Plug 'flowtype/vim-flow'

" visual
Plug 'jacoborus/tender.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-scripts/vim-webdevicons'

" typing
Plug 'mattn/emmet-vim'
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

" tmux
Plug 'tyewang/vimux-jest-test'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'

" additional
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'w0rp/ale'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-repeat'

" autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins' }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install -g tern' }
Plug 'carlitux/deoplete-ternjs'

call plug#end()
