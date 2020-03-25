" ----------------------------------- TESTING -----------------------------------
let test#strategy = "neovim"
" let test#enabled_runners = ["javascript#mocha", "javascript#jest"]

let test#javascript#mocha#file_pattern = "\\v((spec|test).*)$"
let test#javascript#mocha#executable = "npm test -s --"
"
" let test#javascript#jest#file_pattern = "\\v((Enzyme|Test|test).*)$"
let test#javascript#jest#executable = "npm test -s --"

" ----------------------------------- HTML/JSX -----------------------------------
let g:closetag_filenames = '*.html,*.js,*.jsx,*.ts,*.tsx'

" ----------------------------------- LIGHTLINE -----------------------------------
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [['mode', 'paste'], [], ['filename', 'modified']],
      \   'right': [[], ['filetype', 'percent', 'lineinfo', 'cocstatus'], ['gitbranch']]
      \ },
      \ 'inactive': {
      \   'left': [['relativepath']],
      \   'right': []
      \ },
      \ 'component': {
      \   'bufnum': '%n',
      \   'inactive': 'inactive'
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status',
      \   'blame': 'coc_git_blame'
      \ },
      \ 'subseparator': {
      \   'left': '',
      \   'right': ''
      \ }
      \}

" ----------------------------------- THEME -----------------------------------
set termguicolors
if !empty(glob('~/.config/nvim/plugged'))
  let base16colorspace=256
  colorscheme xcodelight
endif
highlight SignColumn guibg=none

" ----------------------------------- NERD -----------------------------------
"  tree
let NERDTreeShowHidden=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeMinimalUI=1

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "*",
    \ "Staged"    : "+",
    \ "Untracked" : "?",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "x",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Ignored"   : "☒",
    \ "Unknown"   : "?"
    \ }

" commenter
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign='left'
let g:NERDCommentEmptyLines=1
let g:NERDTrimTrailingWhitespace=1
let g:NERDCompactSexyComs=1

let g:NERDTreeWinSize=45

" If more than one window and previous buffer was NERDTree, go back to it.
" autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif

" ----------------------------------- UltiSnips -----------------------------------
let g:UltiSnipsExpandTrigger='<c-l>'
let g:UltiSnipsJumpForwardTrigger='<c-l>'
let g:UltiSnipsJumpBackwardTrigger='<c-h>'

" ----------------------------------- CoC -----------------------------------
let g:coc_node_path = '/Users/morganmccauley/.nvm/versions/node/v10.5.0/bin/node'
let g:coc_global_extensions = [
    \'coc-tsserver',
    \'coc-rls',
    \'coc-tslint-plugin',
    \'coc-eslint',
    \'coc-json',
    \'coc-snippets',
    \'coc-prettier',
    \'coc-css',
    \'coc-yank',
    \'coc-git',
    \]

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

highlight link CocErrorSign GruvboxRed
" highlight link CocWarningSign GruvboxRed
" highlight link CocInforSign
" highlight link CocHintSign GruvboxRed

autocmd BufEnter *.js :silent let myIndex = SearchPatternInFile("@flow") | call SwitchFlowOrTsLsps(myIndex)
autocmd BufEnter *.jsx :silent let myIndex = SearchPatternInFile("@flow") | call SwitchFlowOrTsLsps(myIndex)

function! SwitchFlowOrTsLsps(flowIndex)
  silent let stats = CocAction("extensionStats")
  silent let tsserver = get(filter(copy(stats), function('FindTsServer')), 0)
  if(a:flowIndex == 0)
    if(tsserver.state == 'disabled')
      call CocActionAsync("toggleExtension", "coc-tsserver")
    endif
  else
    if(tsserver.state == 'activated')
      call CocActionAsync("toggleExtension", "coc-tsserver")
    endif
  endif
endfunction

function! FindTsServer(idx, value) 
  return a:value.id == 'coc-tsserver'
endfunction


function! SearchPatternInFile(pattern)
    " Save cursor position.
    let save_cursor = getcurpos()

    " Set cursor position to beginning of file.
    call cursor(0, 0)

    " Search for the string 'hello' with a flag c.  The c flag means that a
    " match at the cursor position will be accepted.
    let search_result = search(a:pattern, "c")

    " Set the cursor back at the saved position.  The setpos function was
    " used here because the return value of getcurpos can be used directly
    " with it, unlike the cursor function.
    call setpos('.', save_cursor)

    " If the search function didn't find the pattern, it will have
    " returned 0, thus it wasn't found.  Any other number means that an instance
    " has been found.
    return search_result
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

" -------------------------------- FZF ---------------------------------------------

command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)

" make fzf a floating window
let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

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
  let s:orig_fzf_default_opts = get(s:, 'orig_fzf_default_opts', $FZF_DEFAULT_OPTS)
  let $FZF_DEFAULT_OPTS = s:orig_fzf_default_opts . (empty(cols) ? '' : (' --color='.join(cols, ',')))
endfunction

augroup _fzf
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

" ------------------------------- VIM WIKi--------------------------------------------

let g:vimwiki_list = [{'path': '~/vimwiki/',
      \'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0
" let g:vimwiki_conceallevel = 0
" let g:indentLine_conceallevel = 0

" --------------------------------- LeaderF ---------------------------------------

let g:Lf_PreviewInPopup = 1
let g:Lf_WindowPosition = 'popup'

" -----------------------------------------------------------------------------------

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

let g:javascript_plugin_flow = 1

let g:indentLine_char = "|"
