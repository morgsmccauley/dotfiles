command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)

function! s:update_fzf_colors()
  let rules =
  \ { 'fg':      [['Normal',       'fg']],
    \ 'bg':      [['Normal',       'bg']],
    \ 'hl':      [['Comment',      'fg']],
    \ 'fg+':     [['CursorColumn', 'fg'], ['Normal', 'fg']],
    \ 'bg+':     [['CursorColumn', 'bg']],
    \ 'hl+':     [['Statement',    'fg']],
    \ 'info':    [['PreProc',      'fg']],
    \ 'prompt':  [['Conditional',  'fg']],
    \ 'pointer': [['Exception',    'fg']],
    \ 'marker':  [['Keyword',      'fg']],
    \ 'spinner': [['Label',        'fg']],
    \ 'header':  [['Comment',      'fg']] }
  let cols = []
  for [name, pairs] in items(rules)
    for pair in pairs
      let code = synIDattr(synIDtrans(hlID(pair[0])), pair[1])
      if !empty(name) && !empty(code)
        call add(cols, name.':'.code)
        break
      endif
    endfor
  endfor
  " temp putting here because i don't know the timing of autocmd
  let $FZF_DEFAULT_OPTS = '--layout=reverse'
  let s:orig_fzf_default_opts = get(s:, 'orig_fzf_default_opts', $FZF_DEFAULT_OPTS)
  let $FZF_DEFAULT_OPTS = s:orig_fzf_default_opts . (empty(cols) ? '' : (' --color='.join(cols, ',')))
endfunction

augroup _fzf
  " make fzf a floating window
  " let g:fzf_layout = { 'window': 'call FloatingFZF()' }
  let g:fzf_layout = { 'down': '50%' }
  autocmd!
  autocmd VimEnter,ColorScheme * call s:update_fzf_colors()
augroup END

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr((&lines - 3) / 2)
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)
  let row = float2nr((&lines - height) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

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
  echom 'Checking out branch: '. a:line
  silent exec '!git checkout ' a:line
endfunction

function! GitBranch()
  call fzf#run(fzf#wrap({
        \ 'source': 'git branch',
        \ 'sink': function('s:checkout_branch'),
        \ 'options': [
        \ '--prompt', 'Branches> ',
        \ '--preview', '',
        \ ],
        \ }))
endfunction

function! s:checkout_pull(line)
  if a:line[0] == 'ctrl-o'
    echom 'Opening PR in web: ' . a:line[1]
    silent exec '!gh pr view --web ' . a:line[1]
    return 
  end

  echom 'Checking out PR: ' . a:line[1]
  silent exec '!gh pr checkout ' a:line[1]
endfunction

function! GitPullRequest()
  call fzf#run(fzf#wrap({
        \ 'source': 'gh pr list --limit 100',
        \ 'sink*': function('s:checkout_pull'),
        \ 'options': [
        \ '--prompt', 'Pull Requests> ',
        \ '--preview', 'gh pr view {1}',
        \ '--header', ':: '.s:magenta('ENTER', 'Special').'-checkout, '.s:magenta('CTRL-O', 'Special').'-view',
        \ '--expect', 'ctrl-o',
        \ ],
        \ }))
endfunction

function! s:git_commit(line) 
  let pat = '[0-9a-f]\{7,9}'
  let hash = join(filter(map(a:line[1:], 'matchstr(v:val, pat)'), 'len(v:val)'))

  if a:line[0] == 'ctrl-y'
    return s:yank_to_register(hash)
  end

  if a:line[0] == 'ctrl-r'
    silent exec '!git reset --soft '.hash.'~1'
    return
  end

  if a:line[0] == 'ctrl-i'
    exec 'Git rebase -i --autostash --autosquash '.hash.'~1'
    return
  end

  if a:line[0] == 'ctrl-f'
    silent exec '!git commit --fixup='.hash
    exec '!GIT_SEQUENCE_EDITOR=: git rebase -i --autosquash --autostash '.hash.'~1'
    return
  end
endfunction

" \ '--preview', 'echo {} | grep -o "[a-f0-9]\{7,\}" | head -1 | xargs git show --format=format: --color=always | head -1000',
function! GitCommit()
  call fzf#run(fzf#wrap({
        \ 'source': 'git log --color=always '.fzf#shellescape('--format=%C(auto)%h%d %s %C(green)%cr'),
        \ 'sink*': function('s:git_commit'),
        \ 'options': [
        \ '--ansi',
        \ '--prompt', 'Commits> ',
        \ '--expect', 'ctrl-y,ctrl-f,ctrl-r,ctrl-i',
        \ '--header', ':: '.s:magenta('ENTER', 'Special').'-view, '.s:magenta('CTRL-Y', 'Special').'-yank, '.s:magenta('CTRL-F', 'Special').'-fixup, '.s:magenta('CTRL-R', 'Special').'-reset, '.s:magenta('CTRL-I', 'Special').'-rebase.',
        \ '--preview', 'echo {} | grep -o "[a-f0-9]\{7,\}" | head -1 | xargs git show --stat -p --color=always | head -1000',
        \ ],
        \ }))
endfunction

function! s:git_stash(line)
  if len(a:line) > 2
    let stashes = reverse(map(a:line[1:], {_, line -> split(line)[0]}))

    if a:line[0] == 'ctrl-d'
      for stash in stashes
        echom 'Dropping stash: '.stash
        silent exec '!git stash drop '.stash
      endfor
      return
    end

    echom 'No associated action for multiple lines'
    return
  end

  let stash = split(a:line[1])[0]

  if a:line[0] == 'ctrl-a'
    silent exec '!git stash apply '.stash
  end

  if a:line[0] == 'ctrl-p'
    silent exec '!git stash pop '.stash
  end

  if a:line[0] == 'ctrl-d'
    silent exec '!git stash drop '.stash
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
        \ '--expect', 'ctrl-a,ctrl-p,ctrl-d',
        \ '--preview', 'git stash show --stat -p --color=always {1}',
        \ '--header', ':: '.s:magenta('ENTER', 'Special').'-view, '.s:magenta('CTRL-A', 'Special').'-apply, '.s:magenta('CTRL-P', 'Special').'-pop, '.s:magenta('CTRL-D', 'Special').'-drop',
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

