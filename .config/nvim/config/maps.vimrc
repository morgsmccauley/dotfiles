let mapleader=" "

nmap ; A;<Esc>

" faster scrolling
nnoremap <silent> <C-e> 5<C-e>
nnoremap <silent> <C-y> 5<C-y>
noremap <C-j> 5j
noremap <C-k> 5k

" Prevent arrows
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

map <CR> o<Esc>k

" centre after changin cursor position
nnoremap n nzz
nnoremap N Nzz
nnoremap } }zz
nnoremap { {zz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

nnoremap QQ :qall<CR>

nnoremap gb :ls<CR>:b<Space>

nnoremap <Leader>nh :noh<CR>

nnoremap <C-p> :GFiles<CR>

cnoreabbrev tree NERDTreeToggle
cnoreabbrev blame Gblame
cnoreabbrev find NERDTreeFind
cnoreabbrev diff Gdiff

nnoremap <Leader>gg :Ggrep<space>-i<space>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>nf :NERDTreeFind<CR>
nnoremap <Leader>tn :tabNext<CR>
nnoremap <Leader>tp :tabPrev<CR>
nnoremap <Leader>t :tabn<space>
nnoremap <Leader>nh :noh<CR>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

imap cll console.log()<Esc>_f(a
vmap cll yocll<Esc>p
nmap cll yiwocll<Esc>a'<Esc>a<Esc>pf)i, <Esc>p
