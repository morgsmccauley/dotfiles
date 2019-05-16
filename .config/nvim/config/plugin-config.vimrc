" ----------------------------------- TESTING -----------------------------------
let test#strategy = "neovim"
let test#enabled_runners = ["javascript#mocha", "javascript#jest"]

let test#javascript#mocha#file_pattern = "\\v((spec|test).*)$"
let test#javascript#mocha#executable = "npm test -s --"

let test#javascript#jest#file_pattern = "\\v((Enzyme|Test|test).*)$"

" ----------------------------------- HTML/JSX -----------------------------------
let g:closetag_filenames = '*.html,*.js,*.jsx,*.ts,*.tsx'

" ----------------------------------- LIGHTLINE -----------------------------------
let g:lightline = {
      \ 'active': {
      \   'left': [['mode', 'paste'], [], ['relativepath', 'modified']],
      \   'right': [['cocstatus'], ['filetype', 'percent', 'lineinfo'], ['gitbranch']]
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
" let ayucolor="light"
let ayucolor="mirage"
" let ayucolor="dark"
colorscheme ayu
highlight SignColumn guibg=none

" ----------------------------------- NERD -----------------------------------
"  tree
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeShowLineNumbers=1

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

let g:coc_node_path = '/Users/morganmccauley/.nvm/versions/node/v10.5.0/bin/node'

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

highlight link CocErrorSign GruvboxRed
" highlight link CocWarningSign GruvboxRed
" highlight link CocInforSign
" highlight link CocHintSign GruvboxRed

" ---------------------------------------------------------------------------------

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" vim rooter
let g:rooter_patterns = ['package.json', '.git/']
let g:rooter_resolve_links = 1

let g:javascript_plugin_flow = 1

command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
