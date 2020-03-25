let mapleader=" "

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

" testing
nnoremap <Leader>t :TestNearest<CR>
nnoremap <Leader>T :TestFile<CR>
nnoremap <Leader>TT :TestSuite<CR>

" yank file path
nnoremap <Leader>yp :let @" = expand("%")<CR>

" split resize
nnoremap <Leader>> 10<C-w>>
nnoremap <Leader>< 10<C-w><

" quick semi
nnoremap <Leader>; $a;<Esc>

" fold
nnoremap <Leader>ff Vi}zf

" upper case
nnoremap <Leader>c' vi'~e
nnoremap <Leader>cw viw~e

nnoremap <Esc> :noh<CR><Esc>

" faster scrolling
nnoremap <silent> <C-e> 5<C-e>
nnoremap <silent> <C-y> 5<C-y>

" map <CR> o<Esc>k

" indent
nnoremap <Leader>i vip=
nnoremap <Leader>I ggvG=2<C-o>zz

" comment
nnoremap <Leader>cc vip<space>c<space>

" fast reload
nnoremap <Leader>e :edit!<CR>

nnoremap QQ :qall<CR>

nnoremap <C-p> :GFiles<CR>
nnoremap <C-g> :Rg<CR>
nnoremap <C-c> :CocList commands<CR>
nnoremap <C-b> :Buffers<CR>
" nnoremap <C-f> :GFiles?<CR>
nnoremap <C-s> :Gstatus<CR>
nnoremap <C-n> :NERDTreeFind<CR>

nnoremap <c-w>gf :vertical wincmd f<CR>

function! OpenTerminal()
  " move to right most buffer
  execute "normal 5\<C-l>"

  let bufNum = bufnr("%")
  let bufType = getbufvar(bufNum, "&buftype", "not found")

  if bufType == "terminal"
    " close existing terminal
    execute "q"
  else
    " open terminal
    execute "vsp term://zsh"

    " turn off numbers
    execute "setlocal nonu"
    execute "setlocal nornu"
    execute "setlocal noshowmode"
    execute "setlocal noruler"
    " execute "setlocal laststatus=0"
    execute "setlocal noshowcmd"

    " toggle insert on enter/exit
    silent au BufLeave <buffer> stopinsert!
    silent au BufWinEnter,WinEnter <buffer> startinsert!

    " set maps inside terminal buffer
    execute "tnoremap <buffer> <C-\\><C-\\> <C-\\><C-n>"
    execute "tnoremap <buffer> <C-h> <C-\\><C-n><C-w><C-h>"
    execute "tnoremap <buffer> <C-t> <C-\\><C-n>:q<CR>"

    startinsert!
  endif
endfunction
nnoremap <C-t> :call OpenTerminal()<CR>

function! Fold()
  if (foldclosed('.') > -1)
    execute "normal zd"
  else
    execute "normal vi{zf"
  endif
endfunction
nnoremap <C-f> :call Fold()<CR>

nnoremap <C-,> :bp<CR>
nnoremap <C-.> :bn<CR>

nnoremap <C-h> <C-w><C-h>
nnoremap <C-l> <C-w><C-l>
noremap <C-k> 5k
noremap <C-j> 5j

" CoC
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>fe  <Plug>(coc-fix-current)

autocmd CursorHold * silent call CocActionAsync('highlight')

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" shorter commands
cnoreabbrev name echo @%
cnoreabbrev blame Gblame
cnoreabbrev find NERDTreeFind
cnoreabbrev diff Gdiff
cnoreabbrev config source ~/.config/nvim/init.vim
cnoreabbrev errors CocList diagnostics
