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
cnoreabbrev grep Ggrep<space>-i

nnoremap <Leader>nh :noh<CR>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

" quick logs
nmap <Leader>ll yiwoconsole.log('',)<Esc>_f'pf,p$
nmap <Leader>tt yiwoR.tap(args => console.log('', args))<Esc>_f'p$

" Repeat the last command in the last tmux pane
function! s:TmuxRepeat()
  silent! exec "!tmux select-pane -l && tmux send up enter && tmux select-pane -l"
  redraw!
endfunction

noremap <Leader>r :call <SID>TmuxRepeat()<CR>
