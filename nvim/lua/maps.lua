vim.g.mapleader = ' '

local function nmap(lhs, rhs, opts)
  opts = opts or {}
  vim.api.nvim_set_keymap('n', lhs, rhs, opts)
end

local function imap(lhs, rhs, opts)
  opts = opts or {}
  vim.api.nvim_set_keymap('i', lhs, rhs, opts)
end

local function vmap(lhs, rhs, opts)
  opts = opts or {}
  vim.api.nvim_set_keymap('v', lhs, rhs, opts)
end

local function cmap(lhs, rhs, opts)
  opts = opts or {}
  vim.api.nvim_set_keymap('c', lhs, rhs, opts)
end

vim.keymap.set({ 'n', 'v' }, 'j', 'gj', { silent = true, noremap = true })
vim.keymap.set({ 'n', 'v' }, 'k', 'gk', { silent = true, noremap = true })

nmap('<C-l>', '<C-w>l', { noremap = true })
nmap('<C-h>', '<C-w>h', { noremap = true })
nmap('<C-j>', '<C-w>j', { noremap = true })
nmap('<C-k>', '<C-w>k', { noremap = true })

vim.keymap.set('n', '<C-w>gf', '<C-w>vgf',
  { desc = 'Go to file in new split' })
vim.keymap.set('n', '<C-w>gd', '<Cmd>silent vsp | Telescope lsp_definitions<Cr>',
  { desc = 'Go to definition in new split' })

nmap('<C-p>', '@:', { noremap = true })

imap('<C-a>', '<C-o>^', { noremap = true, silent = true })
-- imap('<C-e>', '<C-o>$', { noremap = true, silent = true })

nmap('<C-q>', '<Cmd>silent q<Cr>', { noremap = true, silent = true })
nmap('<C-S-q>', '<Cmd>silent bw<Cr>', { noremap = true, silent = true })
nmap('<C-s>', '<Cmd>w<Cr>', { noremap = true, silent = true })

nmap('<Esc>', '<Cmd>noh | echo ""<Cr>', { silent = true, noremap = true })
nmap('QQ', '<Cmd>qall<CR>', { noremap = true })

nmap('K', '<Cmd>lua vim.lsp.buf.hover()<Cr>', { silent = true })

nmap('gd', '<Cmd>silent Telescope lsp_definitions<Cr>', { silent = true })
nmap('gD', '<Cmd>Telescope lsp_type_definitions<CR>', { silent = true })
nmap('gi', '<Cmd>Telescope lsp_implementations<Cr>', { silent = true })
nmap('gr', '<Cmd>Telescope lsp_references<Cr>', { silent = true })

vim.keymap.set({ 'n', 'v' }, '<C-e>', '5<C-e>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-y>', '5<C-y>', { noremap = true, silent = true })

nmap('dl', 'dV:LeapLine<Cr>', { noremap = true, silent = true })
nmap('yl', 'yV:LeapLine<Cr>', { noremap = true, silent = true })
nmap('cl', 'cV:LeapLine<Cr>', { noremap = true, silent = true })

cmap('<C-a>', '<C-b>', { noremap = true })

vmap('J', ':m \'>+1<Cr>gv=gv', { noremap = true })
vmap('K', ':m \'<-2<Cr>gv=gv', { noremap = true })

vim.keymap.set('c', '<C-r>', function()
  return '<Plug>(TelescopeFuzzyCommandSearch)'
end, { expr = true, remap = true })

vim.keymap.set('n', ';', ':', { noremap = true })
