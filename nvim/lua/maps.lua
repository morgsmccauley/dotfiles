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

vim.keymap.set('n', 'g.', function()
  local dir = utils.find_project_root()
  vim.cmd.cd(dir)
end, { noremap = true })
vim.keymap.set('n', 'g-', function()
  vim.cmd.cd('-')
end, { noremap = true })

vim.keymap.set('n', 'gr', function()
  require('snacks').picker.lsp_references()
end, { silent = true })
vim.keymap.set('n', 'gd', function()
  require('snacks').picker.lsp_definitions()
end, { silent = true })
vim.keymap.set('n', 'gD', function()
  require('snacks').picker.lsp_type_definitions()
end, { silent = true })
vim.keymap.set('n', 'gi', function()
  require('snacks').picker.lsp_implementations()
end, { silent = true })
vim.keymap.set('n', 'gs', '<Cmd>lua vim.lsp.buf.signature_help()<Cr>', { silent = true })

vim.keymap.set({ 'n', 'v' }, '<C-e>', '5<C-e>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-y>', '5<C-y>', { noremap = true, silent = true })

cmap('<C-a>', '<C-b>', { noremap = true })

nmap('J', 'mzJ`z', { noremap = true })

vim.keymap.set('c', '<C-r>', function()
  return '<Plug>(TelescopeFuzzyCommandSearch)'
end, { expr = true, remap = true })

vim.keymap.set('n', ';', ':', { noremap = true })

vim.keymap.set('n', '<C-w><C-l>', '<Cmd>tabnext<Cr>', { noremap = true, silent = true, desc = "Go to next tab" })
vim.keymap.set('n', '<C-w><C-h>', '<Cmd>tabprev<Cr>', { noremap = true, silent = true, desc = "Go to previous tab" })

vim.keymap.set('n', '<C-a>', 'ggVG', { noremap = true, silent = true })

-- Window keymaps
vim.keymap.set('n', '<leader>wq', '<Cmd>q<Cr>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>wQ', '<Cmd>wq<Cr>', { desc = 'Save and quit' })
vim.keymap.set('n', '<leader>ww', '<Cmd>silent w<Cr>', { desc = 'Save' })
vim.keymap.set('n', '<leader>wr', '<C-w>r', { desc = 'Rotate' })
vim.keymap.set('n', '<leader>wo', '<Cmd>only<Cr>', { desc = 'Close all other windows' })
vim.keymap.set('n', '<leader>wl', '<Cmd>luafile %<Cr>', { desc = 'Source selected lua file' })
vim.keymap.set('n', '<leader>wv', '<Cmd>vsp<Cr>', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>w=', '<C-w>=', { desc = 'Balance windows' })
vim.keymap.set('n', '<leader>wm', '<C-w>|', { desc = 'Maximise window' })

-- Git Hunk keymaps
vim.keymap.set('n', '<leader>ghs', '<Cmd>lua require\'gitsigns\'.stage_hunk()<Cr>', { desc = 'Stage' })
vim.keymap.set('n', '<leader>ghu', '<Cmd>lua require\'gitsigns\'.undo_stage_hunk()<Cr>', { desc = 'Undo stage' })
vim.keymap.set('n', '<leader>ghi', '<Cmd>lua require\'gitsigns\'.preview_hunk()<Cr>', { desc = 'Preview' })
vim.keymap.set('n', '<leader>ghr', '<Cmd>lua require\'gitsigns\'.reset_hunk()<Cr>', { desc = 'Reset' })

-- Debug keymaps
vim.keymap.set('n', '<leader>dn', '<Cmd>lua require"dap".step_over()<Cr>', { desc = 'Step over' })
vim.keymap.set('n', '<leader>di', '<Cmd>lua require"dap".step_into()<Cr>', { desc = 'Step into' })
vim.keymap.set('n', '<leader>do', '<Cmd>lua require"dap".step_out()<Cr>', { desc = 'Step out' })
vim.keymap.set('n', '<leader>dc', '<Cmd>lua require"dap".continue()<Cr>', { desc = 'Continue' })
vim.keymap.set('n', '<leader>dC', '<Cmd>lua require"dap".clear_breakpoints()<Cr>', { desc = 'Clear breakpoints' })
vim.keymap.set('n', '<leader>ds', '<Cmd>lua require"dap".terminate()<Cr>', { desc = 'Stop' })
vim.keymap.set('n', '<leader>db', '<Cmd>lua require"dap".toggle_breakpoint()<Cr>', { desc = 'Toggle breakpoint' })
vim.keymap.set('n', '<leader>dh', function() require('dap.ui.widgets').hover() end,
  { desc = 'View value for expression under cursor' })
vim.keymap.set('n', '<leader>dB', '<Cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<Cr>',
  { desc = 'Set breakpoint with condition' })
vim.keymap.set('n', '<leader>dr',
  function()
    require('dap').repl.toggle()
    vim.api.nvim_command "call win_gotoid(win_findbuf(bufnr('dap-repl'))[0])"
  end, { desc = 'Toggle repl' })
vim.keymap.set('n', '<leader>du', '<Cmd>lua require"dapui".toggle()<Cr>', { desc = 'Toggle ui' })
vim.keymap.set('n', '<leader>d<Cr>', function()
  require('which-key').show({
    keys = '<leader>d',
    loop = true
  })
end, { desc = 'Hydra' })

-- Git Diff keymaps
vim.keymap.set('n', '<leader>gdi', '<Cmd>DiffviewOpen<Cr>', { desc = 'Index' })
vim.keymap.set('n', '<leader>gdb', '<Cmd>DiffviewOpen main...HEAD<Cr>', { desc = 'Branch' })
vim.keymap.set('n', '<leader>gdc', '<Cmd>DiffviewClose<Cr>', { desc = 'Close' })
vim.keymap.set('n', '<leader>gdf', '<Cmd>DiffviewToggleFiles<Cr>', { desc = 'Toggle files pane' })
vim.keymap.set('n', '<leader>gdh', '<Cmd>DiffviewFileHistory %<Cr>', { desc = 'File history' })

-- Marks keymaps
vim.keymap.set('n', '<leader>mD', '<Cmd>delmarks!<Cr>', { desc = 'Delete all marks for current buffer' })
vim.keymap.set('n', '<leader>mm', '<Cmd>norm\'<Cr>', { desc = 'List marks' })

-- Buffer keymaps
vim.keymap.set('n', '<leader>be', '<Cmd>edit<Cr>', { desc = 'Edit buffer' })
vim.keymap.set('n', '<leader>by', '<Cmd>let @* = expand("%")<Cr>', { desc = 'Yank filename' })
vim.keymap.set('n', '<leader>bl', function() vim.bo[0].buflisted = true end, { desc = 'List buffer' })
vim.keymap.set('n', '<leader>bx', ':source %<Cr>', { desc = 'Source buffer' })
vim.keymap.set('n', '<leader>bs', function()
  vim.cmd.new('[Scratch]')
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'hide'
  vim.bo.swapfile = false
  vim.bo.buflisted = false
  vim.api.nvim_command('wincmd J')
end, { desc = 'Open scratch buffer' })

-- Code keymaps
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })
vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<leader>cd', '<Cmd>Trouble diagnostics toggle filter.buf=0<Cr>', { desc = 'File diagnostics' })
vim.keymap.set('n', '<leader>cD', '<Cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.ERROR<Cr>',
  { desc = 'Workspace error diagnostics' })
vim.keymap.set('n', '<leader>cs', '<Cmd>Trouble symbols focus<Cr>', { desc = 'Code symbols' })
vim.keymap.set('n', '<leader>cl', vim.diagnostic.open_float, { desc = 'Show diagnostics for current line' })
vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, { desc = 'Format' })
vim.keymap.set('n', '<leader>ch', vim.lsp.buf.hover, { desc = 'Hover' })
vim.keymap.set('n', '<leader>cg', vim.lsp.buf.signature_help, { desc = 'Signature help' })
vim.keymap.set('n', '<leader>ct', function() require('telescope.builtin').grep_string({ search = 'TODO|FIX|NOTE' }) end,
  { desc = 'Search TODO comments' })

-- Neotest keymaps
vim.keymap.set('n', '<leader>nt', function()
  require('neotest').run.run()
end, { desc = 'Run nearest' })
vim.keymap.set('n', '<leader>nf', function()
  require('neotest').run.run(vim.fn.expand('%'))
end, { desc = 'Run file' })
vim.keymap.set('n', '<leader>nd', function()
  require('neotest').run.run({ strategy = 'dap' })
end, { desc = 'Run with debugger' })
vim.keymap.set('n', '<leader>nl', function()
  require('neotest').run.run_last()
end, { desc = 'Run last' })
vim.keymap.set('n', '<leader>ns', function()
  require('neotest').summary.toggle()
end, { desc = 'Toggle summary' })
vim.keymap.set('n', '<leader>no', function()
  require('neotest').output_panel.toggle()
end, { desc = 'Toggle output panel' })


vim.keymap.set('n', '<C-t><C-t>', function()
  vim.cmd.tabnew()
  require('termbuf.api').open_terminal({ dir = utils.find_project_root() or vim.uv.cwd() })
end, { desc = 'Open terminal in new tab' })

vim.keymap.set('n', '<C-t><C-l>', function()
  vim.cmd.vsplit()
  require('termbuf.api').open_terminal({ dir = utils.find_project_root() or vim.uv.cwd() })
end, { desc = 'Open terminal to right' })

vim.keymap.set('n', '<C-t><C-j>', function()
  vim.cmd('belowright split')
  require('termbuf.api').open_terminal({ dir = utils.find_project_root() or vim.uv.cwd() })
end, { desc = 'Open terminal below' })

vim.keymap.set('n', '<leader>to', function()
  require('termbuf.api').open_terminal()
end, { desc = 'Open terminal in current window' })
vim.keymap.set('n', '<leader>tt', function()
  vim.cmd.tabnew()
  require('termbuf.api').open_terminal()
end, { desc = 'Open terminal in new tab' })
vim.keymap.set('n', '<leader>tv', function()
  vim.cmd.vsplit()
  require('termbuf.api').open_terminal()
end, { desc = 'Open terminal in vertical split' })
vim.keymap.set('n', '<leader>ts', function()
  vim.cmd('belowright split')
  require('termbuf.api').open_terminal()
end, { desc = 'Open terminal in horizontal split' })
vim.keymap.set('n', '<leader>tr', function()
  vim.cmd.vsplit()
  require('termbuf.api').open_terminal({ dir = utils.find_project_root() or vim.uv.cwd() })
end, { desc = 'Open terminal at project root' })

-- File keymaps
vim.keymap.set('n', '<leader>fo', function()
  require('mini.files').open()
end, { desc = 'Open file explorer' })
vim.keymap.set('n', '<leader>fp', function()
  require('mini.files').open(vim.api.nvim_buf_get_name(0))
end, { desc = 'Open file explorer from parent' })

local function open_aider_term()
  vim.cmd.tabnew()
  require('termbuf.api').open_terminal({ cmd = 'aider --watch-files' })
  vim.cmd.tabprev()
  -- termbuf triggers startinsert on open
  vim.cmd.stopinsert()
end

-- Aider keymaps
vim.keymap.set('n', '<leader>at', function()
  open_aider_term()
end, { desc = 'Open aider terminal in new tab' })

vim.keymap.set('n', '<leader>aa', function()
  local aider_term = require('utils').find_aider_terminal()
  if not aider_term then
    open_aider_term()
  end
  aider_term = require('utils').find_aider_terminal()

  -- Get current buffer filename
  local filename = vim.fn.expand('%:p')

  -- Send add command to aider terminal
  aider_term:send("/add " .. filename)
end, { desc = 'Add file to aider' })

vim.keymap.set('n', '<leader>ac', function()
  local prefix = vim.bo.commentstring:gsub('%%s.*', '')
  vim.fn.feedkeys('O' .. prefix .. 'ai! ')
end, { desc = 'Insert aider comment' })

-- Search and other keymaps
vim.keymap.set('n', '<leader>/', function()
  require('snacks').picker.lines()
end, { desc = 'Search buffer' })

vim.keymap.set('n', '<leader>*', function()
  require('snacks').picker.grep_word({ hidden = true })
end, { desc = 'Search for symbol globally' })

vim.keymap.set('n', '<leader>?', function()
  require('snacks').picker.grep({ hidden = true })
end, { desc = 'Search globally' })

vim.keymap.set('n', '<leader>,', function()
  require('snacks').picker.buffers()
end, { desc = 'Find buffer' })

vim.keymap.set('n', '<leader>.', function()
  require('snacks').picker.smart({ hidden = true })
end, { desc = 'Find file' })

vim.keymap.set('n', '<leader>\'', function()
  require('snacks').picker.marks()
end, { desc = 'List marks' })

vim.keymap.set('n', '<leader>;', function()
  require('snacks').picker.command_history({
    layout = { preset = "ivy" }
  })
end, { desc = 'List command history' })

vim.keymap.set({ 'i', 's' }, '<c-l>', function()
  if vim.snippet.active({ direction = 1 }) then
    return '<cmd>lua vim.snippet.jump(1)<cr>'
  else
    return '<c-l>'
  end
end, { expr = true })

vim.keymap.set({ 'i', 's' }, '<c-h>', function()
  if vim.snippet.active({ direction = -1 }) then
    return '<cmd>lua vim.snippet.jump(-1)<cr>'
  else
    return '<c-h>'
  end
end, { expr = true })

vim.keymap.set({ 'i', 's' }, '<c-n>', function()
  if vim.snippet.active({ direction = -1 }) then
    return '<cmd>lua vim.snippet.jump(-1)<cr>'
  else
    return '<c-h>'
  end
end, { expr = true })
