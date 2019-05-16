call plug#begin()

" syntax
Plug 'sheerun/vim-polyglot'
Plug 'ianks/vim-tsx'

" status bar
Plug 'maximbaz/lightline-ale'
Plug 'itchyny/lightline.vim'

" themes
Plug 'yarisgutierrez/ayu-lightline'
Plug 'ayu-theme/ayu-vim'

" tree
Plug 'scrooloose/nerdtree'

" typing
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

" autocomplete
Plug 'sirver/ultisnips'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'neoclide/coc-tsserver', { 'do': { -> 'yarn install --frozen-lockfile' } }
Plug 'neoclide/coc-prettier', { 'do': { -> 'yarn install --frozen-lockfile' } }
Plug 'neoclide/coc-json', { 'do': { -> 'yarn install --frozen-lockfile' } }
Plug 'neoclide/coc-tslint-plugin', { 'do': { -> 'yarn install --frozen-lockfile' } }
Plug 'neoclide/coc-eslint', { 'do': { -> 'yarn install --frozen-lockfile' } }

" test
Plug 'janko-m/vim-test'

" IDE
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-signify'
Plug 'yggdroot/indentline'
Plug 'scrooloose/nerdcommenter'

" git
Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-repeat'

Plug 'airblade/vim-rooter'

call plug#end()
