let mapleader=" "
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

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
      \ '\': [':call MonkeyTerminalQuit() | source ~/.config/nvim/init.vim', 'Reload config'],
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

let g:which_key_map['s'] = {
      \ 'name': '+session',
      \ 'l': [':call Sessions()', 'List'],
      \ 'q': [':SClose', 'Quit'],
      \ 's': [':SSave!', 'Save']
      \ }

let remote = {
      \ 'name': '+remote',
      \ 'p': [':echo "Pushing to remote..." | Git push', 'Push'],
      \ 'P': [':echo "Force pushing to remote..." | Git push --force-with-lease', 'Force push'],
      \ 'u': ['!gpsup', 'Push creating upstream'],
      \ 'l': [':echo "Pulling from remote..." | Git pull', 'Pull'],
      \ 'f': [':echo "Fetching remote..." | Git fetch', 'Fetch'],
      \ 'y': [':CocCommand git.copyUrl', 'Copy GitHub URL of current line'],
      \ }

let rebase = {
      \ 'name': '+rebase',
      \ 'skip': ['Git rebase --skip', 'skip'],
      \ 'continue': ['Git rebase --continue', 'continue'],
      \ 'abort': ['Git rebase --abort', 'abort'],
      \ }

let g:which_key_map['g'] = {
      \ 'name': '+git',
      \ 'l': [':call GitLog()', 'Log'],
      \ 'p': [':call GitPullRequest()', 'Pull requests'],
      \ 'b': [':call GitBranch()', 'Branches'],
      \ 's': [':call GitStash()', 'Stash'],
      \ 'L': [':BCommits', 'Buffer log'],
      \ 'i': ['<plug>(GitGutterPreviewHunk)', 'Preview hunk'],
      \ 'u': ['<plug>(GitGutterUndoHunk)', 'Undo hunk'],
      \ '[': ['<plug>(GitGutterPrevHunk)', 'Go to prev hunk'],
      \ ']': ['<plug>(GitGutterNextHunk)', 'Go to next hunk'],
      \ 'r': remote,
      \ 'R': rebase,
      \ 'B': [':Gblame', 'Blame annotations'],
      \ 'C': [':CocCommand git.showCommit', 'Show commit'],
      \ 'g': [':Git', 'Git'],
      \ }

command! -nargs=? -range Align <line1>,<line2>call AlignSection('<args>')

function! AlignSection(regex) range
  let extra = 1
  let sep = empty(a:regex) ? '=' : a:regex
  let maxpos = 0
  let section = getline(a:firstline, a:lastline)
  for line in section
    let pos = match(line, ' *'.sep)
    if maxpos < pos
      let maxpos = pos
    endif
  endfor
  call map(section, 'AlignLine(v:val, sep, maxpos, extra)')
  call setline(a:firstline, section)
endfunction

function! AlignLine(line, sep, maxpos, extra)
  let m = matchlist(a:line, '\(.\{-}\) \{-}\('.a:sep.'.*\)')
  if empty(m)
    return a:line
  endif
  let spaces = repeat(' ', a:maxpos - strlen(m[1]) + a:extra)
  return m[1] . spaces . m[2]
endfunction

let g:which_key_map['c'] = {
      \ 'name': '+code',
      \ 'a': [":'<,'>Align", 'Align selection by ='],
      \ 'd': ['<Plug>coc-definition', 'Go to definition'],
      \ 'r': ['<Plug>coc-references', 'List references'],
      \ 'n': ['<Plug>coc-rename', 'Rename variable'],
      \ 't': ['<Plug>coc-type-definition', 'Go to type definition'],
      \ 'i': ['vip=', 'Indent block'],
      \ 'I': ['ggvG=2', 'Indent file'],
      \ '/': ['<Plug>NERDCommenterToggle', 'Comment line or selection'],
      \ 'e': [':CocList diagnostics', 'List errors'],
      \ 'c': [':CocCommand', 'List Coc commands'],
      \ 'f': [':CocCommand eslint.executeAutofix', 'Execute eslint fix'],
      \ }

function! SearchAndReplaceGlobal()
  let search_term = input("Search term: ")
  let replace_term = input("Replace with: ")
  let confirm = input("Confirm replaces? (y)es/(n)o: ")

  if confirm == 'y'
    exec 'cdo s/'.search_term.'/'.replace_term.'/egc | update'
    return
  end

  if confirm == 'n'
    exec 'cdo s/'.search_term.'/'.replace_term.'/eg | update'
    return
  end

  echom 'Invalid confirm input'
endfunction

let g:which_key_map['q'] = {
      \ 'name': '+quickfix',
      \ 'q': ['ccl', 'Quit'],
      \ 'n': ['cn | zz', 'Next'],
      \ 'p': ['cp | zz', 'Previous'],
      \ 'f': ['cfirst', 'First'],
      \ 'l': ['clast', 'Last'],
      \ 'a': [':call SearchAndReplaceGlobal()', 'Do a global search/replace'],
      \ }

let g:which_key_map['w'] = {
      \ 'name': '+window' ,
      \ 'a': ['1<C-w>w', 'Go to first window'],
      \ 's': ['2<C-W>w', 'Go to second window'],
      \ 'd': ['3<C-W>w', 'Go to third window'],
      \ 'f': ['4<C-W>w', 'Go to fourth window'],
      \ 'w': ['<C-W>w', 'Other window'],
      \ 'q': [':q', 'Quit window'],
      \ 'Q': [':wq', 'Save and quit window'],
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
      \ 'v': ['<C-W>v', 'Split window below'],
      \ }

let g:which_key_map['f'] = {
      \ 'name': '+file',
      \ 's': [':w', 'Save file'],
      \ 'S': [':source %', 'Source file'],
      \ 'y': [':let @" = expand("%")', 'Yank filename'],
      \ 'f': ['vi{zf', 'Fold inside {}'],
      \ 'o': ['zo', 'Open fold'],
      \ }

function! CloseHiddenBuffers()
  " figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
  " close any buffer that are loaded and not visible
  let l:tally = 0
  for b in range(1, bufnr('$'))
    if buflisted(b) && !has_key(visible, b)
      let l:tally += 1
      exe 'bw! ' . b
    endif
  endfor
  echon "Deleted " . l:tally . " buffers"
endfun

let g:which_key_map['b'] = {
      \ 'name': '+buffer',
      \ 'k': [':bwipeout!', 'Kill buffer'],
      \ 'K': [':call CloseHiddenBuffers()', 'Kill nested buffers'],
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
