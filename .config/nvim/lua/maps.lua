vim.g.mapleader = " "

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

vmap('<C-j>', '5j', { noremap = true })
vmap('<C-k>', '5k', { noremap = true })

nmap('<C-t>', ':call MonkeyTerminalToggle()<Cr>', { silent = true, noremap = true })
nmap('<C-n>', ':NvimTreeToggle<Cr>', { silent = true, noremap = true })
nmap('<C-l>', '<C-w>l', { noremap = true })
nmap('<C-h>', '<C-w>h', { noremap = true })
nmap('<C-j>', '5j', { noremap = true })
nmap('<C-k>', '5k', { noremap = true })
nmap('<C-e>', '5<C-e>', { noremap = true })
nmap('<C-y>', '5<C-y>', { noremap = true })
nmap('<Esc>', ':noh | echo ""<Cr><Esc>', { silent = true, noremap = true })
nmap('QQ', ':qall<CR>', { noremap = true })

nmap('ga', '<cmd>lua vim.lsp.buf.code_action()<Cr>', { silent = true, noremap = true })
nmap('<S-k>', '<cmd>lua vim.lsp.buf.hover()<Cr>', { silent = true, noremap = true })
nmap('gd', '<cmd>lua vim.lsp.buf.definition()<Cr>', { silent = true, noremap = true })
nmap('gD', '<cmd>lua vim.lsp.buf.implementation()<CR>', { silent = true, noremap = true })
--nnoremap('<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { silent = true })
nmap('1gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { silent = true, noremap = true })
nmap('gr', '<cmd>lua vim.lsp.buf.references()<CR>', { silent = true, noremap = true })
nmap('g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', { silent = true, noremap = true })
nmap('gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', { silent = true, noremap = true })
--nnoremap('gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', { silent = true })

imap('<Tab>', 'pumvisible() ? \"\\<C-n>\" : \"\\<Tab>\"', { expr = true, noremap = true })
imap('<S-Tab>', 'pumvisible() ? \"\\<C-p>\" : \"\\<S-Tab>\"', { expr = true, noremap = true })

imap('<Tab>', '<Plug>(completion_smart_tab)')
imap('<S-Tab>', '<Plug>(completion_smart_s_tab)')

--nmap("<C-_>", "<Plug>kommentary_motion_default")
nmap("<C-_>", "<Plug>kommentary_line_default")
vmap("<C-_>", "<Plug>kommentary_visual_default")
