vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'markdown' },
    command = 'setlocal wrap'
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'TelescopePrompt' },
    command = 'let b:autopairs_enabled = 0'
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'TelescopeResults', 'TelescopePrompt', 'TelescopePreview' },
    command = 'set nocursorline'
})

vim.api.nvim_create_autocmd({ 'WinEnter' }, {
    pattern = { '*' },
    command = 'set cursorline'
})

vim.api.nvim_create_autocmd({ 'WinLeave' }, {
    pattern = { '*' },
    command = 'set nocursorline'
})

vim.api.nvim_create_autocmd({ 'Bufread' }, {
    pattern = { '*.http' },
    command = 'set ft=http'
})

vim.api.nvim_create_autocmd({ 'Bufread' }, {
    pattern = { '*.sh.tmpl' },
    command = 'set ft=sh'
})

vim.api.nvim_create_autocmd({ 'VimResized' }, {
    pattern = { '*' },
    command = 'wincmd ='
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'dap-repl' },
    callback = function(t)
        vim.api.nvim_buf_set_keymap(t.buf, 'i', '<C-h>', [[<C-\><C-n><C-W><C-h>]], { noremap = true })
        vim.api.nvim_buf_set_keymap(t.buf, 'i', '<C-\\>', [[<C-\><C-n>]], { noremap = true })
        vim.api.nvim_buf_set_keymap(t.buf, 'i', '<C-j>', [[<C-\><C-n><C-W><C-j>]], { noremap = true })
        vim.api.nvim_buf_set_keymap(t.buf, 'i', '<C-k>', [[<C-\><C-n><C-W><C-k>]], { noremap = true })

        vim.api.nvim_create_autocmd({ 'BufEnter' }, {
            buffer = t.buf,
            command = 'startinsert!'
        })
    end
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'help' },
    command = 'wincmd K',
    once = false
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'qf' },
    command = 'wincmd J',
    once = false
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'gitcommit', 'gitrebase', 'gitconfig' },
    command = 'set bufhidden=delete'
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'gitcommit' },
    command = 'startinsert'
})

vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
    callback = function()
        vim.highlight.on_yank { timeout = 250 }
    end
})
