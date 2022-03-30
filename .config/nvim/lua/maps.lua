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

nmap('<C-t>', ':call MonkeyTerminalToggle()<Cr>', { silent = true, noremap = true })
nmap('<C-n>', ':NvimTreeFindFileToggle<Cr>', { silent = true, noremap = true })
nmap('<C-l>', '<C-w>l', { noremap = true })
nmap('<C-h>', '<C-w>h', { noremap = true })
nmap('<C-j>', '<C-w>j', { noremap = true })
nmap('<C-k>', '<C-w>k', { noremap = true })

nmap('<C-6>', ':e #<Cr>', { noremap = true })
nmap('<C-x>', ':q<Cr>', { noremap = true })
nmap('<C-s>', ':SymbolsOutline<Cr>', { noremap = true })

nmap('<Esc>', ':noh | echo ""<Cr><Esc>', { silent = true, noremap = true })
nmap('QQ', ':qall<CR>', { noremap = true })

nmap('\\', '<cmd>HopWordMW<Cr>', { noremap = true, silent = true })
nmap('<C-\\>', '<cmd>HopLine<Cr>', { noremap = true, silent = true })
vmap('\\', '<cmd>HopWord<Cr>', { noremap = true, silent = true })
vmap('<C-\\>', '<cmd>HopLine<Cr>', { noremap = true, silent = true })

nmap('s', ':HopChar1<Cr>', { noremap = true, silent = true })

nmap('K', ':lua vim.lsp.buf.hover()<Cr>', { silent = true })

nmap('gd', ':Telescope lsp_definitions<Cr>', { silent = true })
nmap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { silent = true })
nmap('gi', ':Telescope lsp_implementations<Cr>', { silent = true })
nmap('gr', ':Telescope lsp_references<Cr>', { silent = true })

nmap('<C-e>', '5<C-e>', { noremap = true, silent = true })
nmap('<C-y>', '5<C-y>', { noremap = true, silent = true })

imap('<Tab>', 'pumvisible() ? \"\\<C-n>\" : \"\\<Tab>\"', { expr = true, noremap = true })
imap('<S-Tab>', 'pumvisible() ? \"\\<C-p>\" : \"\\<S-Tab>\"', { expr = true, noremap = true })

nmap("<C-_>", "<Plug>kommentary_line_default")
vmap("<C-_>", "<Plug>kommentary_visual_default")

nmap("<C-m>", ":MaximizerToggle!<Cr>")

-- https://github.com/phaazon/hop.nvim/issues/82
nmap('dl', 'dV:HopLine<Cr>', { noremap = true, silent = true })
nmap('yl', 'yV:HopLine<Cr>', { noremap = true, silent = true })
nmap('cl', 'cV:HopLine<Cr>', { noremap = true, silent = true })

-- nmap('t', ':HopChar1CurrentLineAC<Cr>', { noremap = true, silent = true })
nmap('dt', 'd:HopChar1CurrentLineAC<Cr>', { noremap = true, silent = true })
nmap('yt', 'y:HopChar1CurrentLineAC<Cr>', { noremap = true, silent = true })
nmap('ct', 'c:HopChar1CurrentLineAC<Cr>', { noremap = true, silent = true })

nmap('f', ':HopChar1CurrentLineAC<Cr>', { noremap = true, silent = true })
nmap('df', 'd:lua require"hop".hint_char1({ direction = require"hop.hint".HintDirection.AFTER_CURSOR, inclusive_jump=true, current_line_only=true })<Cr>', { noremap = true, silent = true })
nmap('yf', 'y:lua require"hop".hint_char1({ direction = require"hop.hint".HintDirection.AFTER_CURSOR, inclusive_jump=true, current_line_only=true })<Cr>', { noremap = true, silent = true })
nmap('cf', 'c:lua require"hop".hint_char1({ direction = require"hop.hint".HintDirection.AFTER_CURSOR, inclusive_jump=true, current_line_only=true })<Cr>', { noremap = true, silent = true })
