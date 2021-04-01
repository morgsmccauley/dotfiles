vim.g.mapleader = " "

local function nnoremap(lhs, rhs, opts)
  opts = opts or {}
  vim.api.nvim_set_keymap('n', lhs, rhs, vim.tbl_extend('force', opts, { noremap = true }))
end

local function inoremap(lhs, rhs, opts)
  opts = opts or {}
  vim.api.nvim_set_keymap('i', lhs, rhs, vim.tbl_extend('force', opts, { noremap = true }))
end

local function vnoremap(lhs, rhs, opts)
  opts = opts or {}
  vim.api.nvim_set_keymap('v', lhs, rhs, vim.tbl_extend('force', opts, { noremap = true }))
end

vnoremap('<C-j>', '5j')
vnoremap('<C-k>', '5k')

nnoremap('<C-t>', ':call MonkeyTerminalToggle()<Cr>', { silent = true })
nnoremap('<C-n>', ':NvimTreeToggle<Cr>', { silent = true })
nnoremap('<C-l>', '<C-w>l')
nnoremap('<C-h>', '<C-w>h')
nnoremap('<C-j>', '5j')
nnoremap('<C-k>', '5k')
nnoremap('<C-e>', '5<C-e>')
nnoremap('<C-y>', '5<C-y>')
nnoremap('<Esc>', ':noh | echo ""<Cr><Esc>', { silent = true })
nnoremap('QQ', ':qall<CR>')

inoremap('<Tab>', 'pumvisible() ? \\<C-n> : \\<Tab>', { expr = true })
inoremap('<S-Tab>', 'pumvisible() ? \\<C-p> : \\<S-Tab>', { expr = true })
