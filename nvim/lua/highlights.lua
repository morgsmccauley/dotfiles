vim.cmd 'hi LineNr guibg=NONE'
vim.cmd 'hi SignColumn guibg=NONE'
vim.cmd 'hi VertSplit guibg=NONE'
vim.cmd 'hi DiffAdd guifg=#81A1C1 guibg = none'
vim.cmd 'hi DiffChange guifg =#3A3E44 guibg = none'
vim.cmd 'hi DiffModified guifg = #81A1C1 guibg = none'
vim.cmd 'hi EndOfBuffer guifg=#282c34'

vim.cmd 'hi PmenuSel  guibg=#98c379'

vim.cmd 'hi DiagnosticSignError guifg=#DF8890'
vim.cmd 'hi DiagnosticSignWarn guifg=#EBCB8B'
vim.cmd 'hi DiagnosticSignInfo guifg=#81A1C1'
vim.cmd 'hi DiagnosticSignHint guifg=#A3BE8C'

vim.cmd 'hi FocusedSymbol cterm=italic ctermfg=4 ctermbg=11 gui=bold,italic guifg=darkblue'

vim.fn.sign_define('DiagnosticSignError', { numhl = 'DiagnosticSignError', texthl = 'DiagnosticSignError', text = '' })
vim.fn.sign_define('DiagnosticSignHint',
    { italic = false, numhl = 'DiagnosticSignHint', texthl = 'DiagnosticSignHint', text = '' })
vim.fn.sign_define('DiagnosticSignWarn', { numhl = 'DiagnosticSignWarn', texthl = 'DiagnosticSignWarn', text = '' })
vim.fn.sign_define('DiagnosticSignInfo', { numhl = 'DiagnosticSignInfo', texthl = 'DiagnosticSignInfo', text = '' })
