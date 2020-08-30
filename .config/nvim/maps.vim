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

nnoremap <C-t> :call MonkeyTerminalToggle()<CR>

let g:which_key_map =  {
      \ '/': [':Rg', 'Search globally'],
      \ ',': [':Buffers', 'Switch buffer'],
      \ '\': [':source ~/.config/nvim/init.vim', 'Reload config'],
      \ }

" Defining the '.' binding inside the key map causes delays for some reason
let g:which_key_map['.'] = 'Find file'
nnoremap <leader>. :GFiles<cr>

let g:which_key_map['*'] = 'Search for symbol globally'
nnoremap <leader>* yiw:Rg <C-r>+<CR>

let g:which_key_map['m'] = {
      \ 'name': '+motion',
      \ 'l': ['<Plug>(easymotion-overwin-line)', 'Move to line'],
      \ 's': ['<Plug>(easymotion-overwin-f2)', 'Move to 2 char'],
      \ 'c': ['<Plug>(easymotion-overwin-f)', 'Move to char'],
      \ 'w': ['<Plug>(easymotion-overwin-w)', 'Move to word']
      \ }

let list = {
      \ 'name': '+list',
      \ 'c': [':call GitCommit()', 'Commits'],
      \ 'B': [':BCommits', 'Buffer commits'],
      \ 'b': [':call GitBranch()', 'Branches'],
      \ 'p': [':call GitPullRequest()', 'Pull requests'],
      \ 'm': [':GFiles?', 'Modified'],
      \ 's': [':call GitStash()', 'Stash'],
      \ }

let remote = {
      \ 'name': '+remote',
      \ 'p': [':Gpush', 'Push'],
      \ 'P': ['!gpsup', 'Push creating upstream'],
      \ 'l': ['!Gpull', 'Pull'],
      \ 'y': [':CocCommand git.copyUrl', 'Copy GitHub URL of current line'],
      \ 'c': [':call MonkeyTerminalExec("gh pr create")', 'Create PR'],
      \ }

let hunk = {
      \ 'name': '+hunk',
      \ 'i': ['<plug>(GitGutterPreviewHunk)', 'Preview hunk'],
      \ 'u': ['<plug>(GitGutterUndoHunk)', 'Undo hunk'],
      \ 'p': ['<plug>(GitGutterPrevHunk)', 'Go to prev hunk'],
      \ 'n': ['<plug>(GitGutterNextHunk)', 'Go to next hunk'],
      \ }

let g:which_key_map['g'] = {
      \ 'name': '+git',
      \ 'l': list,
      \ 'r': remote,
      \ 'h': hunk,
      \ 'b': [':Gblame', 'Blame'],
      \ 'g': [':Git', 'Git'],
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
      \ 'Q': [':wq', 'Save and quit window'],
      \ 'd': ['<C-W>c', 'Delete window'],
      \ 'D': [':only', 'Delete all other windows'],
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
      \ 'k': [':bwipeout!', 'Kill buffer'],
      \ 'K': [':call BufferDelete()', 'Kill buffers'],
      \ 'r': [':edit!', 'Reload buffer'],
      \ 'l': [':BLines', 'Buffer lines'],
      \ }

let g:which_key_map['o'] = {
      \ 'name': '+open',
      \ 't': [':call MonkeyTerminalToggle()', 'Terminal'],
      \ 'p': [':NERDTreeToggle', 'Project side bar'],
      \ 'P': [':NERDTreeFind', 'Find file in project side bar'],
      \ }

" let g:which_key_map['t'] = {
      " \ 'name': '+test',
      " \ 't': [':TestNearest', 'Run test at point'],
      " \ 'f': [':TestNearest', 'Run tests in file'],
      " \ 'p': [':TestNearest', 'Run project tests'],
      " \ }

let g:which_key_map['t'] = {
      \ 'name': '+terminal',
      \ 't': [':call MonkeyTerminalOpen()', 'Open or go to terminal'],
      \ 'h': [':call MonkeyTerminalClose()', 'Hide terminal'],
      \ 'r': [':call MonkeyTerminalExecLastCommand()', 'Repeat last command'],
      \ }
