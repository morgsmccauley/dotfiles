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
    pattern = {'*.tsx', '*.ts', '*.jsx', '*.js'},
    command = 'EslintFixAll'
})

vim.api.nvim_create_autocmd({'VimResized'}, {
    pattern = {'*'},
    command = 'wincmd ='
})

vim.api.nvim_create_autocmd({'FileType'}, {
    pattern = {'dap-repl'},
    command = 'startinsert!'
})

vim.api.nvim_create_autocmd({'FileType'}, {
    pattern = {'dap-repl'},
    callback = function(t)
        vim.api.nvim_buf_set_keymap(t.buf, 't', '<C-h>', [[<C-\><C-n><C-W><C-h>]], { noremap = true })
        vim.api.nvim_buf_set_keymap(t.buf, 't', '<C-\\>', [[<C-\><C-n>]], { noremap = true })
        vim.api.nvim_buf_set_keymap(t.buf, 't', '<C-j>', [[<C-\><C-n><C-W><C-j>]], { noremap = true })
        vim.api.nvim_buf_set_keymap(t.buf, 't', '<C-k>', [[<C-\><C-n><C-W><C-k>]], { noremap = true })
    end
})

vim.api.nvim_create_autocmd({'BufWritePost'}, {
    pattern = {'.config/nvim/lua/plugins/init.lua'},
    command = 'source <afile> | PackerCompile'
})
