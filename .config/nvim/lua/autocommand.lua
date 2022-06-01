vim.api.nvim_create_autocmd({'FileType'}, {
    pattern = {'markdown'},
    command = 'setlocal wrap'
})

vim.api.nvim_create_autocmd({'FileType'}, {
    pattern = {'TelescopePrompt'},
    command = 'let b:autopairs_enabled = 0'
})

vim.api.nvim_create_autocmd({'FileType'}, {
    pattern = {'TelescopeResults', 'TelescopePrompt', 'TelescopePreview'},
    command = 'set nocul'
})

vim.api.nvim_create_autocmd({'WinEnter'}, {
    pattern = {'*'},
    command = 'set cul'
})

vim.api.nvim_create_autocmd({'WinLeave'}, {
    pattern = {'*'},
    command = 'set nocul'
})

vim.api.nvim_create_autocmd({'BufWritePre'}, {
    pattern = {'*.tsx, *.ts, *.jsx, *.js'},
    command = 'EslintFixAll'
})
