" download vim-plug if we don't have it
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  echo "Downloading vim-plug..."
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | q | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.config/nvim/plugged')

" syntax
Plug 'sheerun/vim-polyglot'
Plug 'ianks/vim-tsx'

" status bar
Plug 'itchyny/lightline.vim'

" themes
" Plug 'yarisgutierrez/ayu-lightline', { 'do': 'cp ./ayu.vim ~/.config/nvim/plugged/lightline.vim/autoload/lightline/colorscheme/' }
Plug 'chriskempson/base16-vim'
Plug 'mike-hearn/base16-vim-lightline'
" Plug 'ayu-theme/ayu-vim'

" tree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" typing
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

" autocomplete
Plug 'sirver/ultisnips'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" test
Plug 'janko-m/vim-test'

" fuzzy search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'mhinz/vim-signify'

Plug 'yggdroot/indentline'

Plug 'scrooloose/nerdcommenter'

" git
Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-repeat'

Plug 'vimwiki/vimwiki'

call plug#end()
