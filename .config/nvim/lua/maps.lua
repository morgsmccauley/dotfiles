local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

-- keybind list
map("", "<leader>c", '"+y')

-- open terminals  
map("n", "<C-b>" , [[<Cmd> vnew term://zsh<CR>]] , opt) -- split term vertically , over the right  
map("n", "<C-x>" , [[<Cmd> split term://zsh | resize 10 <CR>]] , opt) -- split term vertically , over the right  

map("n", "<Space>.", [[Telescope git_files]], opt)

vim.cmd("inoremap <expr> <Tab>   pumvisible() ? \"\\<C-n>\" : \"\\<Tab>\"")
vim.cmd("inoremap <expr> <S-Tab>   pumvisible() ? \"\\<C-p>\" : \"\\<S-Tab>\"")
