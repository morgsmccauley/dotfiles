vim.o.hidden = false
vim.o.splitright = true
vim.o.ignorecase = true
vim.o.splitbelow = true
vim.o.termguicolors = true
vim.o.number = true
vim.o.numberwidth = 2
vim.o.wrap = false
vim.cmd[[set noshowmode]]
vim.cmd[[set cursorline]]

vim.o.mouse = 'a'

vim.o.signcolumn = 'yes'
vim.o.cmdheight = 1

--vim.o.nobackup = true
--vim.o.nowritebackup = true

vim.o.updatetime = 250
vim.o.clipboard = 'unnamedplus'

-- for indenline
vim.o.expandtab = true
vim.o.shiftwidth = 2

vim.o.completeopt = 'menuone,noselect,noinsert'
vim.cmd[[set shortmess+=c]]
vim.o.encoding = 'UTF-8'

vim.o.undofile = true
vim.cmd[[set undodir=~/.vim/undo]]

vim.cmd 'colorscheme tokyonight'
-- vim.o.background = 'light'
vim.g.tokyonight_sidebars = { "quickfix", "__vista__", "terminal", "fzf" }
vim.g.tokyonight_italic_keywords = false

vim.cmd 'syntax enable'
vim.cmd 'syntax on'

vim.api.nvim_command[[
autocmd BufEnter *SchemaChangesAreApproved*,*.gql,*.graphql :set filetype=graphql
]]
