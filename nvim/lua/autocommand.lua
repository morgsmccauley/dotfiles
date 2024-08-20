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

vim.api.nvim_create_autocmd({ 'Bufread' }, {
    pattern = { '*.js.snap' },
    command = 'set ft=javascript'
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

vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = { '.yabairc' },
    command = '!yabai --restart-service',
})

vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = { 'aerospace.toml' },
    command = 'silent !aerospace reload-config',
})

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = { vim.fn.expand('~') .. '/.dotfiles/kitty/kitty.conf' },
    command = ':silent !kill -SIGUSR1 $(pgrep -a kitty)'
})

vim.api.nvim_create_autocmd({ 'BufRead' }, {
    pattern = { '*' },
    callback = function(event)
        if vim.fn.getbufvar(event.buf, 'buflist_setup_done') == 1 then
            return
        end

        vim.fn.setbufvar(event.buf, 'buflist_setup_done', 1)

        vim.bo[event.buf].buflisted = false

        vim.api.nvim_create_autocmd({ 'InsertEnter', 'BufModifiedSet', 'TextChanged', 'TextChangedI' }, {
            buffer = event.buf,
            once = true,
            callback = function(ev)
                vim.bo[ev.buf].buflisted = true
            end
        })
    end
})

vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = { "[vV\x16]*:*", "*:[vV\x16]*" },
    callback = function()
        local mode = vim.api.nvim_get_mode().mode
        if mode:match("^[vV\x16]") then
            vim.opt_local.relativenumber = true
        else
            vim.opt_local.relativenumber = false
        end
    end
})
