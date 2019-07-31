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
      \ 'active': {
      \   'left': [['mode', 'paste'], [], ['relativepath', 'modified']],
      \   'right': [[], ['filetype', 'percent', 'lineinfo', 'cocstatus'], ['gitbranch']]
      \ },
      \ 'inactive': {
      \   'left': [['inactive'], ['relativepath']],
      \   'right': [['bufnum']]
      \ },
      \ 'component': {
      \   'bufnum': '%n',
      \   'inactive': 'inactive'
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status'
      \ },
      \ 'colorscheme': 'ayu',
      \ 'subseparator': {
      \   'left': '',
      \   'right': ''
      \ }
      \}

" ----------------------------------- THEME -----------------------------------
set termguicolors
if !empty(glob('~/.config/nvim/plugged'))
  " let ayucolor="light"
  " let ayucolor="dark"
  let ayucolor="mirage"
  colorscheme ayu
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

" ----------------------------------- UltiSnips -----------------------------------
let g:UltiSnipsExpandTrigger='<c-l>'
let g:UltiSnipsJumpForwardTrigger='<c-l>'
let g:UltiSnipsJumpBackwardTrigger='<c-h>'

" ----------------------------------- CoC -----------------------------------

let g:coc_node_path = '/Users/morganmccauley/.nvm/versions/node/v10.5.0/bin/node'
let g:coc_global_extensions = [
    \'coc-tsserver',
    \'coc-rls',
    \'coc-tslint',
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

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, fzf#vim#with_preview(), <bang>0)

" ---------------------------------------------------------------------------------

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

let g:javascript_plugin_flow = 1
