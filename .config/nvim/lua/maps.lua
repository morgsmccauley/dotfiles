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
--[[ nmap('<C-e>', '5<C-e>', { noremap = true })
nmap('<C-y>', '5<C-y>', { noremap = true }) ]]
nmap('<Esc>', ':noh | echo ""<Cr><Esc>', { silent = true, noremap = true })
nmap('QQ', ':qall<CR>', { noremap = true })

-- can we merge sign/number columns and just highlight numbers?

function ShowDocumentation()
  if (vim.bo.filetype == 'vim' or vim.bo.filetype == 'help') then
    vim.api.nvim_command('h '..vim.fn.expand'<cword>')
  elseif (vim.api.nvim_call_function('coc#rpc#ready', {})) then
    vim.api.nvim_call_function('CocActionAsync', {'doHover'})
  else
    vim.api.nvim_command('!'..vim.bo.keywordprg..' '..vim.fn.expand('<cword>'))
  end
end

nmap('<S-k>', ':lua ShowDocumentation()<Cr>', { silent = true })
nmap('gd', '<Plug>(coc-definition)', { silent = true })
nmap('gy', '<Plug>(coc-type-definition)', { silent = true })
nmap('gi', '<Plug>(coc-implementation)', { silent = true })
nmap('gr', '<Plug>(coc-references)', { silent = true })

nmap('<C-e>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "5<C-e>"', { noremap = true, silent = true, nowait = true, expr = true })
nmap('<C-y>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "5<C-y>"', { noremap = true, silent = true, nowait = true, expr = true })

imap('<Tab>', 'pumvisible() ? \"\\<C-n>\" : \"\\<Tab>\"', { expr = true, noremap = true })
imap('<S-Tab>', 'pumvisible() ? \"\\<C-p>\" : \"\\<S-Tab>\"', { expr = true, noremap = true })

imap('<C-space>', 'coc#refresh()', { expr = true, noremap = true, silent = true })

imap('<C-e>', 'coc#float#has_scroll() ? "\\<c-r>=coc#float#scroll(1)\\<cr>" : "\\<Right>"', { silent = true, nowait = true, expr = true })
imap('<C-y>', 'coc#float#has_scroll() ? "\\<c-r>=coc#float#scroll(0)\\<cr>" : "\\<Left>"', { silent = true, nowait = true, expr = true })

imap('<Cr>', 'pumvisible() ? coc#_select_confirm() : "\\<C-g>u\\<CR>\\<c-r>=coc#on_enter()\\<CR>"', { silent = true, expr = true })

nmap("<C-_>", "<Plug>kommentary_line_default")
vmap("<C-_>", "<Plug>kommentary_visual_default")

