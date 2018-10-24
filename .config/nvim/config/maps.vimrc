let mapleader=" "

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>t :RunJestFocused<CR>
nnoremap <Leader>T :RunJestOnBuffer<CR>

" split resize
nnoremap <Leader>> 20<C-w>>
nnoremap <Leader>< 20<C-w><

" quick semi
nnoremap <Leader>; $a;<Esc>

" fold
nnoremap <Leader>ff Vi}zf

" grep
nnoremap <Leader>g :VimuxRunCommand "git grp "<Left>
nnoremap <Leader>gg yiw:VimuxRunCommand "git grp <C-r>""<CR>

" search and replace
nnoremap <Leader>sr yiw:%s/<C-r>"//gc<left><left><left>
vnoremap <Leader>sr y:%s/<C-r>"//gc<left><left><left>

" go to file
nnoremap <silent> <Leader>gf gd/'<CR><C-w>gf<Esc>

" delete surrounding function
nnoremap <Leader>df diwds(

" tabs
" why cant i map this initially..
nnoremap <Tab> gt
nnoremap <S-Tab> gT

" quick logs
nnoremap <Leader>lb i!console.log('') && <Esc>_f'a
nnoremap <Leader>lv yiwoconsole.log('', )<Esc>_f'pf p$
nnoremap <Leader>tt yiwoR.tap(args => console.log('', args)),<Esc>_f'p$

" quick jsx comment
nnoremap <Leader>jl o{ /*  */<Esc>_f*la

" upper case
nnoremap <Leader>c' vi'~e
nnoremap <Leader>cw viw~e

" always add semi to end of line
" nmap ; A;<Esc>

nnoremap <C-[> :noh<Esc>

" faster scrolling
nnoremap <silent> <C-e> 5<C-e>
nnoremap <silent> <C-y> 5<C-y>
noremap <C-j> 5j
noremap <C-k> 5k

map <CR> o<Esc>k

" indent
nnoremap <Leader>i vip=
nnoremap <Leader>I ggvG=2<C-o>zz

" comment
nnoremap <Leader>cc vip<space>c<space>

" fast reload
nnoremap <Leader>e :edit!<CR>

" shorter commands
cnoreabbrev tree NERDTreeToggle
cnoreabbrev blame Gblame
cnoreabbrev find NERDTreeFind
cnoreabbrev diff Gdiff
" cnoreabbrev grep Ggrep<space>-i

" centre after changin cursor position
" nnoremap n nzz
" nnoremap N Nzz
" nnoremap } }zz
" nnoremap { {zz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

nnoremap QQ :qall<CR>
" nnoremap gb :ls<CR>:b<Space>

nnoremap <C-p> :GFiles<CR>

" Repeat the last command in the last tmux pane
function! s:TmuxRepeat()
  silent! exec "!tmux select-pane -l && tmux send up enter && tmux select-pane -l"
  redraw!
endfunction

noremap <Leader>r :call <SID>TmuxRepeat()<CR>
