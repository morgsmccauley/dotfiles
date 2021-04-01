command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep("rg --hidden --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)

let g:rg_command = 'rg --hidden --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always" -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf,scss}" -g "!*.{min.js,swp,o,zip}" -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command.shellescape(<q-args>), 1, <bang>0)

let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment']
  \ }

let $FZF_DEFAULT_OPTS = '--layout=reverse --bind ctrl-u:preview-page-up,ctrl-d:preview-page-down'
let g:fzf_layout = { 'down': '25%' }

let isDarkThemeEnabled = system('defaults read .GlobalPreferences.plist AppleInterfaceStyle') =~ 'Dark'

" doesn't work yet: https://github.com/junegunn/fzf/issues/1885
" let g:fzf_action = {
"   \ 'ctrl-x': function('s:delete_buffers')
"   \ }
"
function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout!' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

function! BufferDelete()
  call fzf#run(fzf#wrap({
        \ 'source': s:list_buffers(),
        \ 'sink*': { lines -> s:delete_buffers(lines) },
        \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
        \ }));
endfunction

function! s:checkout_branch(line)

  let target_branch = trim(a:line[1][2:])
  if a:line[0] == 'ctrl-n'
    let name = input("Branch name: ")

    if (empty(name))
      echom 'No name entered'
      return
    endif

    exec 'Git checkout -b '.name.' '.target_branch
    return
  end

  if a:line[0] == 'ctrl-e'
    echom 'Merging: '.target_branch
    exec 'Git merge '.target_branch
    return
  end

  if a:line[0] == 'ctrl-r'
    " Fetch before rebasing?
    exec '!git rebase --autostash '.target_branch
    echom 'Rebased on to: '.target_branch
    return
  end

  if a:line[0] == 'ctrl-x'
    if confirm("Delete branch: ".target_branch."?") == 1
      exec '!git branch -D '.target_branch
    else
      echom 'Cancelling'
    endif
    return
  end

  echom 'Checking out branch: '.target_branch

  if stridx(target_branch, 'remote') == 0
    exec '!git checkout -t '.target_branch
    return
  end

  exec '!git checkout '.target_branch
endfunction

function! GitBranch()
  call fzf#run(fzf#wrap({
        \ 'source': 'git branch -a',
        \ 'sink*': function('s:checkout_branch'),
        \ 'options': [
        \ '--ansi',
        \ '--prompt', 'Branches> ',
        \ '--preview', 'git log --color=always --stat master..{1}',
        \ '--expect', 'ctrl-r,ctrl-n,ctrl-x,ctrl-e',
        \ '--header', ':: '.s:magenta('ENTER', 'Special').'-checkout, '.s:magenta('CTRL-N', 'Special').'-new branch, '.s:magenta('CTRL-R', 'Special').'-rebase, '.s:magenta('CTRL-X', 'Special').'-delete, '.s:magenta('CTRL-M', 'Special').'-merge',
        \ ],
        \ }))
endfunction

function! s:checkout_pull(line)
  if a:line[0] == 'ctrl-o'
    echom 'Opening PR in web: '.a:line[1]
    silent exec '!gh pr view --web '.a:line[1]
    return
  end

  if a:line[0] == 'ctrl-n'
    let title = input("Title: ")
    let review = confirm("Ready to review? ", "&yes\n&no")
    let reviewFlag = review == 1 ? ' --label "ready for review"' : ''
    exec '!gh pr create --title '.title.reviewFlag
    return
  endif

  echom 'Checking out PR: 'a:line[1]
  silent exec '!gh pr checkout '.a:line[1]
endfunction

function! GitPullRequest()
  call fzf#run(fzf#wrap({
        \ 'source': 'gh pr list --limit 100',
        \ 'sink*': function('s:checkout_pull'),
        \ 'options': [
        \ '--prompt', 'Pull Requests> ',
        \ '--preview', 'gh pr view {1}',
        \ '--header', ':: '.s:magenta('ENTER', 'Special').'-checkout, '.s:magenta('CTRL-O', 'Special').'-view, '.s:magenta('CTRL-N', 'Special').'-new',
        \ '--expect', 'ctrl-o,ctrl-n',
        \ ],
        \ }))
endfunction

function! s:git_log(line) 
  let pat = '[0-9a-f]\{7,9}'
  let hash = join(filter(map(a:line[1:], 'matchstr(v:val, pat)'), 'len(v:val)'))

  if a:line[0] == 'ctrl-y'
    return s:yank_to_register(hash)
  end

  if a:line[0] == 'ctrl-s'
    exec '!git reset --soft '.hash.'~1'
    return
  end

  if a:line[0] == 'ctrl-r'
    exec 'Git rebase -i --autostash --autosquash '.hash.'~1'
    return
  end

  if a:line[0] == 'ctrl-f'
    silent exec '!git commit --fixup='.hash
    exec '!GIT_SEQUENCE_EDITOR=: git rebase -i --autosquash --autostash '.hash.'~1'
    return
  end

  silent exec 'Gvdiffsplit '.hash.'~1'
endfunction

" \ '--preview', 'echo {} | grep -o "[a-f0-9]\{7,\}" | head -1 | xargs git show --format=format: --color=always | head -1000',
function! GitLog()
  call fzf#run(fzf#wrap({
        \ 'source': 'git log --color=always '.fzf#shellescape('--format=%C(auto)%h%d %s %C(green)%cr'),
        \ 'sink*': function('s:git_log'),
        \ 'options': [
        \ '--ansi',
        \ '--prompt', 'Log> ',
        \ '--expect', 'ctrl-y,ctrl-f,ctrl-r,ctrl-s',
        \ '--header', ':: '.s:magenta('ENTER', 'Special').'-view, '.s:magenta('CTRL-Y', 'Special').'-yank, '.s:magenta('CTRL-F', 'Special').'-fixup, '.s:magenta('CTRL-R', 'Special').'-rebase, '.s:magenta('CTRL-s', 'Special').'-soft reset.',
        \ '--preview', 'echo {} | grep -o "[a-f0-9]\{7,\}" | head -1 | xargs git show --stat -p --color=always | head -1000',
        \ ],
        \ }))
endfunction

function! s:git_stash(line)
  if len(a:line) > 2
    let stashes = reverse(map(a:line[1:], {_, line -> split(line)[0]}))

    if a:line[0] == 'ctrl-x'
      if confirm("Delete stashes?") == 1
        for stash in stashes
          echom 'Dropping stash: '.stash
          silent exec '!git stash drop '.stash
        endfor
      endif
      return
    endif

    echom 'No associated action for multiple lines'
    return
  end

  let stash = split(a:line[1])[0]

  if a:line[0] == 'ctrl-a'
    exec '!git stash apply '.stash
    return
  end

  if a:line[0] == 'ctrl-p'
    exec '!git stash pop '.stash
    return
  end

  if a:line[0] == 'ctrl-x'
    if confirm("Delete stash?") == 1
      exec '!git stash drop '.stash
    endif
    return
  end

  if a:line[0] == 'ctrl-n'
    let message = input('Message: ')
    if message == ''
      exec '!git stash push'
      return
    end

    exec '!git stash push --message='.message
    return
  end

  silent exec 'Gdiff '.stash
endfunction

function! GitStash()
  call fzf#run(fzf#wrap({
        \ 'source': 'git stash list --color=always '.fzf#shellescape('--pretty=%C(yellow)%gd %Cgreen%cr %C(blue)%gs'),
        \ 'sink*': function('s:git_stash'),
        \ 'options': [
        \ '--ansi',
        \ '--multi',
        \ '--prompt', 'Stash> ',
        \ '--expect', 'ctrl-a,ctrl-p,ctrl-n,ctrl-x',
        \ '--preview', 'git stash show --stat -p --color=always {1}',
        \ '--header', ':: '.s:magenta('ENTER', 'Special').'-view, '.s:magenta('CTRL-A', 'Special').'-apply, '.s:magenta('CTRL-P', 'Special').'-pop, '.s:magenta('CTRL-X', 'Special').'-drop, '.s:magenta('CTRL-N', 'Special').'-new stash',
        \ ],
        \ }))
endfunction

function s:sessions(line)
  if a:line[0] == 'ctrl-n'
    let dir = input("Project directory: ", "", "file")

    if empty(dir)
      return
    endif

    exec 'SClose'
    exec 'cd '.dir

    let paths  = split(getcwd(), "/")
    let current_dir = paths[len(paths) - 1]

    exec 'SSave! '.current_dir
    return
  endif

  if a:line[0] == 'ctrl-x'
    if confirm("Delete sessions: ".a:line[1]."?") == 1
      exec 'silent SDelete! '.a:line[1]
    endif
    return
  endif

  exec 'SLoad! '.a:line[1]
  return
endfunction

function! Sessions()
  call fzf#run(fzf#wrap({
        \ 'source': 'ls -tA ~/.local/share/nvim/session | grep -v __LAST__',
        \ 'sink*': function('s:sessions'),
        \ 'options': [
        \ '--prompt', 'Sessions> ',
        \ '--expect', 'ctrl-n,ctrl-x',
        \ '--header', ':: '.s:magenta('ENTER', 'Special').'-open, '.s:magenta('CTRL-N', 'Special').'-new, '.s:magenta('CTRL-X', 'Special').'-delete'
        \ ],
        \ }))
endfunction

function! Buffers()
  call fzf#run(fzf#wrap({
        \ 'source': 'ls',
        \ 'sink': 'b',
        \ 'options': [
        \ '--prompt', 'Buffers> ',
        \ ],
        \ }))
endfunction

" Utility functions

function! s:yank_to_register(data)
  let @" = a:data
  silent! let @* = a:data
  silent! let @+ = a:data
endfunction

function! s:get_color(attr, ...)
  let gui = has('termguicolors') && &termguicolors
  let fam = gui ? 'gui' : 'cterm'
  let pat = gui ? '^#[a-f0-9]\+' : '^[0-9]\+$'
  for group in a:000
    let code = synIDattr(synIDtrans(hlID(group)), a:attr, fam)
    if code =~? pat
      return code
    endif
  endfor
  return ''
endfunction

let s:ansi = {'black': 30, 'red': 31, 'green': 32, 'yellow': 33, 'blue': 34, 'magenta': 35, 'cyan': 36}

function! s:csi(color, fg)
  let prefix = a:fg ? '38;' : '48;'
  if a:color[0] == '#'
    return prefix.'2;'.join(map([a:color[1:2], a:color[3:4], a:color[5:6]], 'str2nr(v:val, 16)'), ';')
  endif
  return prefix.'5;'.a:color
endfunction

function! s:ansi(str, group, default, ...)
  let fg = s:get_color('fg', a:group)
  let bg = s:get_color('bg', a:group)
  let color = (empty(fg) ? s:ansi[a:default] : s:csi(fg, 1)) .
        \ (empty(bg) ? '' : ';'.s:csi(bg, 0))
  return printf("\x1b[%s%sm%s\x1b[m", color, a:0 ? ';1' : '', a:str)
endfunction

for s:color_name in keys(s:ansi)
  execute "function! s:".s:color_name."(str, ...)\n"
        \ "  return s:ansi(a:str, get(a:, 1, ''), '".s:color_name."')\n"
        \ "endfunction"
endfor

if has('nvim')
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
endif
