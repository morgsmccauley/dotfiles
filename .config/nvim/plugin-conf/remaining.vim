let isDarkThemeEnabled = system('defaults read .GlobalPreferences.plist AppleInterfaceStyle') =~ 'Dark'

" ----------------------------------- TESTING -----------------------------------
let test#strategy = "neovim"

let test#javascript#mocha#file_pattern = "\\v((spec|test).*)$"
let test#javascript#mocha#executable = "npm test -s --"

let test#javascript#jest#executable = "npm test -s --"

" ----------------------------------- HTML/JSX -----------------------------------
let g:closetag_filenames = '*.html,*.js,*.jsx,*.ts,*.tsx'

" ----------------------------------- LIGHTLINE -----------------------------------
" let lightlineColorscheme = isDarkThemeEnabled ? ''
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
  if isDarkThemeEnabled
    colorscheme xcodedark
  else
    colorscheme xcodelight
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
