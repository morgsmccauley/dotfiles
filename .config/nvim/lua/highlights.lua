vim.cmd 'hi LineNr guibg=NONE'
vim.cmd 'hi SignColumn guibg=NONE'
vim.cmd 'hi VertSplit guibg=NONE'
vim.cmd 'hi DiffAdd guifg=#81A1C1 guibg = none'
vim.cmd 'hi DiffChange guifg =#3A3E44 guibg = none'
vim.cmd 'hi DiffModified guifg = #81A1C1 guibg = none'
vim.cmd 'hi EndOfBuffer guifg=#282c34'

vim.cmd 'hi PmenuSel  guibg=#98c379'

vim.cmd 'hi DiagnosticSignError guifg=#DF8890'
vim.cmd 'hi DiagnosticSignWarning guifg=#EBCB8B'
vim.cmd 'hi DiagnosticSignInformation guifg=#81A1C1'
vim.cmd 'hi DiagnosticSignHint guifg=#A3BE8C'

vim.cmd 'hi CocErrorSign guifg=#DF8890'
vim.cmd 'hi CocWarningSign guifg=#EBCB8B'
vim.cmd 'hi CocInfoSign guifg=#81A1C1'
vim.cmd 'hi CocHintSign guifg=#A3BE8C'

vim.cmd 'hi NvimTreeOpenedFile gui=bold guifg=white'
vim.cmd 'hi NvimTreeFolderIcon guifg=#61afef'
vim.cmd 'hi NvimTreeFolderName guifg=#61afef'
vim.cmd 'hi NvimTreeIndentMarker guifg=#545862'

vim.cmd 'hi TelescopeBorder   guifg=#3e4451'
vim.cmd 'hi TelescopePromptBorder   guifg=#3e4451'
vim.cmd 'hi TelescopeResultsBorder  guifg=#3e4451'
vim.cmd 'hi TelescopePreviewBorder  guifg=#525865'

vim.fn.sign_define("DiagnosticSignError", { texthl = "DiagnosticSignError", text = "" })
vim.fn.sign_define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = "" })
vim.fn.sign_define("DiagnosticSignWarning", { texthl = "DiagnosticSignWarning", text = "" })
vim.fn.sign_define("DiagnosticSignInformation", { texthl = "DiagnosticSignInformation", text = "" })

vim.fn.sign_define("NvimTreeSignError", { texthl = "NvimTreeSignError", text = "" })
vim.fn.sign_define("NvimTreeSignHint", { texthl = "NvimTreeSignError", text = "" })
vim.fn.sign_define("NvimTreeSignWarning", { texthl = "NvimTreeSignError", text = "" })
vim.fn.sign_define("NvimTreeSignInformation", { texthl = "NvimTreeSignError", text = "" })

vim.api.nvim_command('highlight HopNextKey2 guifg=#00dfff')
