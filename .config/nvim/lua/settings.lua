vim.o.hidden = true
vim.o.splitright = true
vim.o.ignorecase = true
-- vim.o.splitright = true
vim.o.termguicolors = true
vim.o.number = true
vim.o.numberwidth = 2
vim.o.wrap = false
vim.o.showmode = false
vim.o.cursorline = true

-- vim.o.rnu = true

vim.o.mouse = 'a'

vim.o.signcolumn = 'yes'
-- vim.o.cmdheight = 0

vim.o.updatetime = 250
vim.o.clipboard = 'unnamedplus'

vim.o.timeoutlen = 250

vim.o.laststatus = 3

vim.o.expandtab = true
vim.o.shiftwidth = 2

vim.o.completeopt = 'menuone,noselect,noinsert'
vim.cmd [[set shortmess+=c]]
vim.o.encoding = 'UTF-8'

vim.o.undofile = true
vim.cmd [[set undodir=~/.vim/undo]]


vim.cmd 'syntax enable'
vim.cmd 'syntax on'
