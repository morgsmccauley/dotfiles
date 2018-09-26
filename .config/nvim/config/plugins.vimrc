call plug#begin()

Plug 'sheerun/vim-polyglot'
" typescript
" Plug 'leafgarland/typescript-vim'
" Plug 'HerringtonDarkholme/yats'
Plug 'ianks/vim-tsx'

" javascript
" Plug 'pangloss/vim-javascript'
" Plug 'isruslan/vim-es6'
" Plug 'mxw/vim-jsx'
Plug 'flowtype/vim-flow'

" status bar
Plug 'maximbaz/lightline-ale'
Plug 'itchyny/lightline.vim'

" visual
Plug 'jacoborus/tender.vim'
Plug 'altercation/vim-colors-solarized'
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
Plug 'yggdroot/indentline'

" autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins' }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install -g tern' }
Plug 'carlitux/deoplete-ternjs'
" Plug 'wokalski/autocomplete-flow'
" Plug 'Shougo/neosnippet'
" Plug 'Shougo/neosnippet-snippets'

call plug#end()
