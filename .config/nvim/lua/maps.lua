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

-- nmap('ga', ':Telescope lsp_code_actions<Cr>', { silent = true, noremap = true })
-- nmap('<S-k>', '<cmd>lua vim.lsp.buf.hover()<Cr>', { silent = true, noremap = true })
-- nmap('<S-d>', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<Cr>', { silent = true, noremap = true })
-- nmap('gd', ':Telescope lsp_definitions<Cr>', { silent = true, noremap = true })
-- nmap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { silent = true, noremap = true })
-- nmap('gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { silent = true, noremap = true })
-- nmap('gr', ':Telescope lsp_references<Cr>', { silent = true, noremap = true })
-- nmap('g0', ':Telescope lsp_document_symbols<Cr>', { silent = true, noremap = true })
-- nmap('gW', ':Telescope lsp_workspace_symbols<Cr>', { silent = true, noremap = true })
-- nmap('gD', ':Telescope lsp_document_diagnostics<Cr>', { silent = true, noremap = true })
-- nmap('gE', ':Telescope lsp_workspace_diagnostics<Cr>', { silent = true, noremap = true })
--nnoremap('<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { silent = true })
--nnoremap('gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', { silent = true })

function ShowDocumentation()
  if (vim.api.nvim_call_function('coc#rpc#ready', {})) then
    vim.api.nvim_call_function('CocActionAsync', {'doHover'})
  end
end

nmap('<S-k>', ':lua ShowDocumentation()<Cr>', { silent = true })
nmap('gd', '<Plug>(coc-definition)', { silent = true })
nmap('gy', '<Plug>(coc-type-definition)', { silent = true })
nmap('gi', '<Plug>(coc-implementation)', { silent = true })
nmap('gr', '<Plug>(coc-references)', { silent = true })

imap('<Tab>', 'pumvisible() ? \"\\<C-n>\" : \"\\<Tab>\"', { expr = true, noremap = true })
imap('<S-Tab>', 'pumvisible() ? \"\\<C-p>\" : \"\\<S-Tab>\"', { expr = true, noremap = true })

-- imap('<C-Space>', 'compe#complete()', { expr = true, noremap = true, silent = true })
-- imap('<Cr>', 'compe#confirm(\'<Cr>\')', { expr = true, noremap = true, silent = true })
-- imap('<C-e>', 'compe#close(\'<C-e>\')', { expr = true, noremap = true, silent = true })
--[[ imap('<C-f>', 'compe#scroll({ \'delta\': +4 })', { expr = true, noremap = true, silent = true })
imap('<C-d>', 'compe#scroll({ \'delta\': -4 })', { expr = true, noremap = true, silent = true }) ]]

--nmap("<C-_>", "<Plug>kommentary_motion_default")
nmap("<C-_>", "<Plug>kommentary_line_default")
vmap("<C-_>", "<Plug>kommentary_visual_default")
