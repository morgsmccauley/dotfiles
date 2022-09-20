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
    command = 'if exists(":EslintFixAll") | execute "EslintFixAll" | endif'
})

vim.api.nvim_create_autocmd({'InsertLeave', 'TextChanged'}, {
    pattern = {'*'},
    command = 'silent! w'
})

vim.api.nvim_create_autocmd({'VimResized'}, {
    pattern = {'*'},
    command = 'wincmd ='
})

vim.api.nvim_create_autocmd({'FileType'}, {
    pattern = {'dap-repl'},
    callback = function(t)
        vim.api.nvim_buf_set_keymap(t.buf, 'i', '<C-h>', [[<C-\><C-n><C-W><C-h>]], { noremap = true })
        vim.api.nvim_buf_set_keymap(t.buf, 'i', '<C-\\>', [[<C-\><C-n>]], { noremap = true })
        vim.api.nvim_buf_set_keymap(t.buf, 'i', '<C-j>', [[<C-\><C-n><C-W><C-j>]], { noremap = true })
        vim.api.nvim_buf_set_keymap(t.buf, 'i', '<C-k>', [[<C-\><C-n><C-W><C-k>]], { noremap = true })

        vim.api.nvim_create_autocmd({'BufEnter'}, {
            buffer = t.buf,
            command = 'startinsert!'
        })
    end
})

vim.api.nvim_create_autocmd({'BufWritePost'}, {
    pattern = {'.config/nvim/lua/plugins/init.lua'},
    command = 'source <afile> | PackerCompile'
})
