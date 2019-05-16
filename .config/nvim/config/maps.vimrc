let mapleader=" "

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

" testing
nnoremap <Leader>t :TestNearest<CR>
nnoremap <Leader>T :TestFile<CR>
nnoremap <Leader>TT :TestSuite<CR>

" yank file path
nnoremap <Leader>yp :let @" = expand("%")


" split resize
nnoremap <Leader>> 10<C-w>>
nnoremap <Leader>< 10<C-w><

" quick semi
nnoremap <Leader>; $a;<Esc>

" fold
nnoremap <Leader>ff Vi}zf

" grep
nnoremap <Leader>gg :VimuxRunCommand "git grp "<Left>
nnoremap <Leader>ggw yiw:VimuxRunCommand "git grp <C-r>""<CR>
nnoremap <Leader>ggf :let @" = expand("%")<cr>:VimuxRunCommand "git grp <C-r><C-w> -- '<C-r>"'"<CR>

" upper case
nnoremap <Leader>c' vi'~e
nnoremap <Leader>cw viw~e

nnoremap <C> :noh<Esc>

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
cnoreabbrev config source ~/.config/nvim/init.vim

nnoremap QQ :qall<CR>

nnoremap <C-p> :GFiles!<CR>
nnoremap <C-g> :Ag!<CR>

nnoremap <Leader><Space> :suspend<CR>

" Repeat the last command in the last tmux pane
function! s:TmuxRepeat()
  silent! exec "!tmux select-pane -l && tmux send up enter && tmux select-pane -l"
  redraw!
endfunction

noremap <Leader>r :call <SID>TmuxRepeat()<CR>

" CoC
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>fe  <Plug>(coc-fix-current)

autocmd CursorHold * silent call CocActionAsync('highlight')

cnoreabbrev errors CocList diagnostics

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)
