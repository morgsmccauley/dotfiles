" ----------------------------------- TESTING -----------------------------------
let test#strategy = "vimux"
let test#enabled_runners = ["javascript#mocha", "javascript#jest"]

let test#javascript#mocha#file_pattern = "\\v((spec|test).*)$"
let test#javascript#mocha#executable = "npm test -s --"

let test#javascript#jest#file_pattern = "\\v((Enzyme|Test).*)$"

" ----------------------------------- HTML/JSX -----------------------------------
let g:closetag_filenames = '*.html,*.js,*.jsx,*.ts,*.tsx'

" ----------------------------------- LIGHTLINE -----------------------------------
let g:lightline = {
   \ 'active': {
   \   'left': [['mode', 'paste'], ['gitbranch', 'filename', 'modified', 'bufferinfo']],
   \   'right': [['linter_errors', 'linter_warnings'], ['percent', 'lineinfo', 'linter_checking', 'linter_ok'], ['filetype']]
   \ },
   \ 'component_function': {
   \   'gitbranch': 'fugitive#head'
   \ },
   \ 'component_expand': {
   \  'linter_checking': 'lightline#ale#checking',
   \  'linter_warnings': 'lightline#ale#warnings',
   \  'linter_errors': 'lightline#ale#errors',
   \  'linter_ok': 'lightline#ale#ok',
   \ },
   \ 'component_type': {
   \  'linter_warnings': 'warning',
   \  'linter_errors': 'error',
   \ },
   \ 'colorscheme': 'ayu'
   \}
let g:lightline#ale#indicator_checking = "\uf017 "
let g:lightline#ale#indicator_warnings = "\uf071  "
let g:lightline#ale#indicator_errors = "\uf05e  "
let g:lightline#ale#indicator_ok = "\uf00c "

let g:ale_echo_msg_format = '[%linter%] %s (%code%)'

autocmd User ALELint call s:MaybeUpdateLightline()

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction

" ----------------------------------- ALE -----------------------------------
let g:ale_linters_explicit = 1
let g:ale_linters = {
      \'javascript': ['eslint', 'flow'],
      \'typescript': ['tslint', 'tsserver', 'typecheck']
      \}
let g:ale_fixers = {
      \'javascript': ['eslint'],
      \'typescript': ['tslint']
      \}
" let g:ale_use_global_executables = 1
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" ----------------------------------- THEME -----------------------------------
set termguicolors
" let ayucolor="light"
let ayucolor="mirage"
" let ayucolor="dark"
" set background=dark
colorscheme ayu
highlight SignColumn guibg=none

" ----------------------------------- FLOW -----------------------------------
let g:flow#enable = 0
let g:javascript_plugin_flow = 1

" ----------------------------------- NERD -----------------------------------
"  tree
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeShowLineNumbers=1
"autocmd bufenter * if (winnr(“$”) == 1 && exists(“b:NERDTreeType”) && b:NERDTreeType == “primary”) | q | endif

" commenter
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign='left'
let g:NERDCommentEmptyLines=1
let g:NERDTrimTrailingWhitespace=1
let g:NERDCompactSexyComs=1

" ----------------------------------- AUTOCOMPLETE -----------------------------------
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" tern
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>

" omnifuncs
augroup omnifuncs
autocmd!
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" tern
if exists('g:plugs["tern_for_vim"]')
let g:tern_show_argument_hints = 'on_hold'
let g:tern_show_signature_in_pum = 1
autocmd FileType javascript setlocal omnifunc=tern#Complete
endif

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})

let g:tern_request_timeout = 1
let g:tern_request_timeout = 6000
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent", "--no-port-file"]

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
