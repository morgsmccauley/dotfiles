let mapleader=" "
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

nnoremap <Esc> :noh<CR><Esc>

nnoremap <silent> <C-e> 5<C-e>
nnoremap <silent> <C-y> 5<C-y>

nnoremap QQ :qall<CR>

nnoremap <c-w>gf :vertical wincmd f<CR>

nnoremap <C-h> <C-w><C-h>
nnoremap <C-l> <C-w><C-l>
noremap <C-k> 5k
noremap <C-j> 5j

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

let g:which_key_map =  {
      \ '*': ['yiw:Rg <C-r>+', 'Search for symbol globally'],
      \ '/': [':Rg', 'Search globally'],
      \ '.': [':GFiles', 'Find file'],
      \ ',': [':Buffers', 'Switch buffer'],
      \ '\': [':source ~/.config/nvim/init.vim', 'Reload config'],
      \ }

let g:which_key_map['g'] = {
      \ 'name': '+git',
      \ 'i': [':CocCommand git.chunkInfo', 'Chunk info'],
      \ 'u': [':CocCommand git.chunkUndo', 'Chunk undo'],
      \ 'U': [':CocCommand git.copyUrl', 'Copy GitHub URL of current line'],
      \ 'g': [':Git', 'Git status'],
      \ 'b': [':Gblame', 'Git Blame'],
      \ 'C': [':Commits', 'Commits'],
      \ 'B': [':BCommits', 'Buffer commits'],
      \ }

let g:which_key_map['c'] = {
      \ 'name': '+code',
      \ 'd': ['<Plug>coc-definition', 'Go to definition'],
      \ 'r': ['<Plug>coc-references', 'List references'],
      \ 'n': ['<Plug>coc-rename', 'Rename variable'],
      \ 't': ['<Plug>coc-type-definition', 'Go to type definition'],
      \ 'i': ['vip=', 'Indent block'],
      \ 'I': ['ggvG=2', 'Indent file'],
      \ '/': ['<Plug>NERDCommenterToggle', 'Comment line or selection'],
      \ 'e': [':CocList diagnostics', 'List errors'],
      \ }

let g:which_key_map['w'] = {
      \ 'name': '+window' ,
      \ 'w': ['<C-W>w', 'Other window'],
      \ 'q': [':q', 'Quit window'],
      \ 'd': ['<C-W>c', 'Delete window'],
      \ '-': ['<C-W>s', 'Split window below'],
      \ '|': ['<C-W>v', 'Split window right'],
      \ '2': ['<C-W>v', 'Layout double columns'],
      \ 'h': ['<C-W>h', 'Window left'],
      \ 'j': ['<C-W>j', 'Window below'],
      \ 'l': ['<C-W>l', 'Window right'],
      \ 'k': ['<C-W>k', 'Window up'],
      \ 'H': ['<C-W>5<', 'Expand window left'],
      \ 'J': [':resize +5', 'Expand window below'],
      \ 'L': ['<C-W>5>', 'Expand window right'],
      \ 'K': [':resize -5', 'Expand window up'],
      \ '=': ['<C-W>=', 'Balance windows'],
      \ 's': ['<C-W>s', 'Split window below'],
      \ 'v': ['<C-W>v', 'Split window below'],
      \ }

let g:which_key_map['f'] = {
      \ 'name': '+file',
      \ 's': [':w', 'Save file'],
      \ 'S': [':source %', 'Source file'],
      \ 'y': [':let @" = expand("%")', 'Yank filename'],
      \ }

let g:which_key_map['b'] = {
      \ 'name': '+buffer',
      \ 'k': [':bwipeout', 'Kill buffer'],
      \ 'K': [':call BufferDelete()', 'Kill buffer'],
      \ 'r': [':edit!', 'Reload buffer'],
      \ 'l': [':BLines', 'Buffer lines'],
      \ }

let g:which_key_map['o'] = {
      \ 'name': '+open',
      \ 't': [':call MonkeyTerminalToggle()', 'Terminal'],
      \ 'p': [':NERDTreeToggle', 'Project side bar'],
      \ 'P': [':NERDTreeFind', 'Find file in project side bar'],
      \ }

let g:which_key_map['t'] = {
      \ 'name': '+test',
      \ 't': [':TestNearest', 'Run test at point'],
      \ 'f': [':TestNearest', 'Run tests in file'],
      \ 'p': [':TestNearest', 'Run project tests'],
      \ }
