local utils = require('utils')

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

vim.keymap.set('n', '<C-space>', '<Cmd>Telescope kitty projects<Cr>', { noremap = true })

nmap('<C-p>', '@:', { noremap = true })

imap('<C-a>', '<C-o>^', { noremap = true, silent = true })
imap('<C-e>', '<C-o>$', { noremap = true, silent = true })

nmap('<C-q>', '<Cmd>silent q<Cr>', { noremap = true, silent = true })
nmap('<C-S-q>', '<Cmd>silent bw<Cr>', { noremap = true, silent = true })
nmap('<C-s>', '<Cmd>w<Cr>', { noremap = true, silent = true })

nmap('<Esc>', '<Cmd>noh | echo ""<Cr>', { silent = true, noremap = true })
nmap('QQ', '<Cmd>qall<CR>', { noremap = true })

vim.keymap.set('n', 'g=', function()
  local dir = utils.find_project_root()
  vim.cmd.cd(dir)
end, { noremap = true })
vim.keymap.set('n', 'g-', function()
  vim.cmd.cd('-')
end, { noremap = true })

nmap('gd', '<Cmd>silent Telescope lsp_definitions<Cr>', { silent = true })
nmap('gD', '<Cmd>Telescope lsp_type_definitions<CR>', { silent = true })
nmap('gi', '<Cmd>Telescope lsp_implementations<Cr>', { silent = true })
vim.keymap.set('n', 'gr', function()
  require('telescope.builtin').lsp_references({
    show_line = false,
  })
end, { silent = true })
vim.keymap.set('n', 'gs', '<Cmd>lua vim.lsp.buf.signature_help()<Cr>', { silent = true })

vim.keymap.set({ 'n', 'v' }, '<C-e>', '5<C-e>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-y>', '5<C-y>', { noremap = true, silent = true })

nmap('dl', 'dV:LeapLine<Cr>', { noremap = true, silent = true })
nmap('yl', 'yV:LeapLine<Cr>', { noremap = true, silent = true })
nmap('cl', 'cV:LeapLine<Cr>', { noremap = true, silent = true })

cmap('<C-a>', '<C-b>', { noremap = true })

nmap('J', 'mzJ`z', { noremap = true })

-- vmap('J', ':m \'>+1<Cr>gv=gv', { noremap = true })
-- vmap('K', ':m \'<-2<Cr>gv=gv', { noremap = true })

vim.keymap.set('c', '<C-r>', function()
  return '<Plug>(TelescopeFuzzyCommandSearch)'
end, { expr = true, remap = true })

vim.keymap.set('n', ';', ':', { noremap = true })

vim.keymap.set('n', '<C-w><C-l>', '<Cmd>tabnext<Cr>', { noremap = true, silent = true, desc = "Go to next tab" })
vim.keymap.set('n', '<C-w><C-h>', '<Cmd>tabprev<Cr>', { noremap = true, silent = true, desc = "Go to previous tab" })

vim.keymap.set('n', '<C-a>', 'ggVG', { noremap = true, silent = true })
