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

local function smap(lhs, rhs, opts)
  opts = opts or {}
  vim.api.nvim_set_keymap('s', lhs, rhs, opts)
end

nmap('j', 'gj', { silent = true, noremap = true })
nmap('k', 'gk', { silent = true, noremap = true })

nmap('<C-S-t>', '<Cmd>ToggleTermToggleAll<Cr>', { silent = true, noremap = true })
nmap('<C-t>', '<Cmd>exe v:count1 . "ToggleTerm"<Cr>', { silent = true, noremap = true })
nmap('<C-n>', '<Cmd>NvimTreeFindFileToggle<Cr>', { silent = true, noremap = true })
nmap('<C-l>', '<C-w>l', { noremap = true })
nmap('<C-h>', '<C-w>h', { noremap = true })
nmap('<C-j>', '<C-w>j', { noremap = true })
nmap('<C-k>', '<C-w>k', { noremap = true })

nmap('<C-w>gf', '<C-w>vgf', { noremap = true })
nmap('<C-w>gd', '<C-w>vgd', { noremap = true })

nmap('<C-p>', '@:', { noremap = true })

imap('<C-l>', '<Plug>luasnip-expand-or-jump', { noremap = true, silent = true })
smap('<C-l>', '<Plug>luasnip-jump-next', { noremap = true, silent = true })
imap('<Backspace>', 'luasnip#jumpable(-1) ? "<Plug>luasnip-jump-prev" : "<Backspace>"',
  { noremap = true, silent = true, expr = true })
smap('<Backspace>', 'luasnip#jumpable(-1) ? "<Plug>luasnip-jump-prev" : "<Backspace>"',
  { noremap = true, silent = true, expr = true })

nmap('<C-g>', '<Cmd>lua require("neogit").open()<Cr>', { noremap = true, silent = true })

imap('<C-a>', '<C-o>^', { noremap = true, silent = true })
imap('<C-e>', '<C-o>$', { noremap = true, silent = true })

nmap('<C-q>', '<Cmd>silent q<Cr>', { noremap = true, silent = true })
nmap('<C-S-q>', '<Cmd>silent bw<Cr>', { noremap = true, silent = true })
nmap('<C-s>', '<Cmd>w<Cr>', { noremap = true, silent = true })

nmap('<Esc>', '<Cmd>noh | echo ""<Cr>', { silent = true, noremap = true })
nmap('QQ', '<Cmd>qall<CR>', { noremap = true })

nmap('K', '<Cmd>lua vim.lsp.buf.hover()<Cr>', { silent = true })

nmap('gd', '<Cmd>silent Telescope lsp_definitions<Cr>', { silent = true })
nmap('gD', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', { silent = true })
nmap('gi', '<Cmd>Telescope lsp_implementations<Cr>', { silent = true })
nmap('gr', '<Cmd>Telescope lsp_references<Cr>', { silent = true })

nmap('<C-e>', '5<C-e>', { noremap = true, silent = true })
nmap('<C-y>', '5<C-y>', { noremap = true, silent = true })

imap('<Tab>', 'pumvisible() ? \"\\<C-n>\" : \"\\<Tab>\"', { expr = true, noremap = true })
imap('<S-Tab>', 'pumvisible() ? \"\\<C-p>\" : \"\\<S-Tab>\"', { expr = true, noremap = true })

nmap('<C-/>', '<Plug>(comment_toggle_linewise_current)')
vmap('<C-/>', '<Plug>(comment_toggle_blockwise_visual)')

nmap('<C-m>', '<Cmd>MaximizerToggle!<Cr>', { noremap = true, silent = true })

nmap('dl', 'dV:lua require(\'plugins/config/leap\').leap_to_line()<Cr>', { noremap = true, silent = true })
nmap('yl', 'yV:lua require(\'plugins/config/leap\').leap_to_line()<Cr>', { noremap = true, silent = true })
nmap('cl', 'cV:lua require(\'plugins/config/leap\').leap_to_line()<Cr>', { noremap = true, silent = true })

cmap('<C-a>', '<C-b>', { noremap = true })
