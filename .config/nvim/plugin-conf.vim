let isDarkThemeEnabled = system('defaults read .GlobalPreferences.plist AppleInterfaceStyle') =~ 'Dark'

" ----------------------------------- TESTING -----------------------------------
let test#strategy = "neovim"

let test#javascript#mocha#file_pattern = "\\v((spec|test).*)$"
let test#javascript#mocha#executable = "npm test -s --"

let test#javascript#jest#executable = "npm test -s --"

" ----------------------------------- HTML/JSX -----------------------------------
let g:closetag_filenames = '*.html,*.js,*.jsx,*.ts,*.tsx'

" ----------------------------------- LIGHTLINE -----------------------------------

let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [['mode', 'paste'], [], ['relativepath', 'modified'], ['lineinfo', 'percent']],
      \   'right': [[], ['filetype', 'cocstatus'], ['gitHunkSummary', 'gitbranch']]
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
      \   'gitHunkSummary': 'GitStatus',
      \   'cocstatus': 'coc#status',
      \   'blame': 'coc_git_blame'
      \ },
      \ 'subseparator': {
      \   'left': '',
      \   'right': ''
      \ }
      \}

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction

" ----------------------------------- THEME -----------------------------------
set termguicolors
colorscheme one
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:one_allow_italics = 1
if !empty(glob('~/.config/nvim/plugged'))
  let base16colorspace=256
  if isDarkThemeEnabled
    set background=dark
  else
    set background=light
  endif
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

let g:NERDCreateDefaultMappings = 0

" If more than one window and previous buffer was NERDTree, go back to it.
" autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif

" ----------------------------------- UltiSnips -----------------------------------
let g:UltiSnipsExpandTrigger='<c-l>'
let g:UltiSnipsJumpForwardTrigger='<c-l>'
let g:UltiSnipsJumpBackwardTrigger='<c-h>'

" -----------------------------------------------------------------------------------

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

let g:javascript_plugin_flow = 1

let g:indentLine_char = "|"

" --------------------------------------- easymotion ---------------------------------

" function! s:incsearch_config(...) abort
"   return incsearch#util#deepextend(deepcopy({
"   \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
"   \   'keymap': {
"   \     "\<CR>": '<Over>(easymotion)'
"   \   },
"   \   'is_expr': 0
"   \ }), get(a:, 1, {}))
" endfunction
"
" noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
" noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
" noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))

let g:gitgutter_map_keys = 0

highlight GitGutterChange guifg=#ffa500 ctermfg=3

" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

function! s:list_commits()
  let commits = systemlist('git log --oneline --pretty="'' <%an> %s (%cr)" -10')
  return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. 'Git' .' show ". matchstr(v:val, "^\\x\\+") }')
endfunction

let g:startify_files_number = 5

let third_window_size = winwidth(0) / 4
let g:startify_padding_left = third_window_size

let g:startify_enable_special = 0

let g:vim_logo = [
      \'    ##############..... ##############   ',
      \'    ##############......##############   ',
      \'      ##########..........##########     ',
      \'      ##########........##########       ',
      \'      ##########.......##########        ',
      \'      ##########.....##########..        ',
      \'      ##########....##########.....      ',
      \'    ..##########..##########.........    ',
      \'  ....##########.#########.............  ',
      \'    ..################JJJ............    ',
      \'      ################.............      ',
      \'      ##############.JJJ.JJJJJJJJJJ      ',
      \'      ############...JJ...JJ..JJ  JJ     ',
      \'      ##########....JJ...JJ..JJ  JJ      ',
      \'      ########......JJJ..JJJ JJJ JJJ     ',
      \'      ######    .........                ',
      \'                  .....                  ',
      \'                    .                    ',
      \]

let g:startify_custom_header = 'startify#center(g:vim_logo)'

let g:startify_lists = [
  \ { 'type': 'dir', 'header': [repeat(" ", third_window_size) . substitute(getcwd(), '^.*/', '', '')] },
  \ { 'type': function('s:gitModified'),  'header': [repeat(" ", third_window_size) . 'Modified']},
  \ { 'type': function('s:gitUntracked'), 'header': [repeat(" ", third_window_size) . 'Untracked']},
  \ { 'type': function('s:list_commits'), 'header': [repeat(" ", third_window_size) . 'Commits']},
  \ ]

" Could use bookmarks to switch projects
let g:startify_change_to_dir = 0
