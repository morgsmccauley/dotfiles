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

vim.api.nvim_create_autocmd({ 'BufRead' }, {
    pattern = { '*.cheat' },
    command = 'set filetype=bash'
})

vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
    callback = function()
        vim.highlight.on_yank { timeout = 250 }
    end
})

vim.api.nvim_create_autocmd({ 'DirChanged' }, {
    pattern = 'global',
    callback = function()
        local current_winnr = vim.fn.winnr()
        local current_bufnr = vim.fn.bufnr()

        vim.cmd('windo lcd ' .. vim.fn.expand('<afile>'))

        vim.api.nvim_buf_set_option(current_bufnr, 'buflisted', true)
        vim.cmd(current_winnr .. 'wincmd w')
    end
})

vim.api.nvim_create_autocmd({ 'TabClosed' }, {
    command = 'tabprevious'
})

vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = { '.yabairc' },
    command = '!launchctl kickstart -k gui/$UID/org.nixos.yabai',
})

vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = { '.skhdrc' },
    command = '!brew services restart skhd',
})

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = { vim.fn.expand('~') .. '/.dotfiles/kitty/kitty.conf' },
    command = ':silent !kill -SIGUSR1 $(pgrep -a kitty)'
})
