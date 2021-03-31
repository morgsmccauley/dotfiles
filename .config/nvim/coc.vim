let g:coc_node_path = '/Users/morganmccauley/.nvm/versions/node/v12.16.1/bin/node'
let g:coc_global_extensions = [
    \'coc-tsserver',
    \'coc-rust-analyzer',
    \'coc-tslint-plugin',
    \'coc-eslint',
    \'coc-json',
    \'coc-snippets',
    \'coc-prettier',
    \'coc-css',
    \'coc-yank',
    \'coc-git',
    \'coc-omnisharp',
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

" highlight link CocErrorSign GruvboxRed
" highlight link CocWarningSign GruvboxRed
autocmd ColorScheme * hi CocInfoSign ctermfg=Blue guifg=#15aabf
" highlight link CocHintSign GruvboxRed

autocmd ColorScheme * hi default link CocErrorHighlight None
autocmd ColorScheme * hi default link CocWarningHighlight None
autocmd ColorScheme * hi default link CocInfoHighlight None
autocmd ColorScheme * hi default link CocHintHighlight None

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

imap <C-l> <Plug>(coc-snippets-expand)
let g:coc_snippet_next = '<c-l>'
let g:coc_snippet_prev = '<c-h>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

let g:coc_status_error_sign = 'E:'
let g:coc_status_warning_sign = 'W:'
