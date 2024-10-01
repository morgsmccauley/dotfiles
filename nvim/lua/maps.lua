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

-- Git Remote keymaps
vim.keymap.set('n', '<leader>grp', '<Cmd>Git push<Cr>', { desc = 'Push' })
vim.keymap.set('n', '<leader>gru', '<Cmd>Git push --set-upstream origin<Cr>', { desc = 'Push creating upstream' })
vim.keymap.set('n', '<leader>grl', '<Cmd>Git pull<Cr>', { desc = 'Pull' })
vim.keymap.set('n', '<leader>grf', '<Cmd>echo "Fetching remote..." | Git fetch<Cr>', { desc = 'Fetch' })
vim.keymap.set('n', '<leader>gry', 'V:GBrowse!<Cr>', { desc = 'Copy GitHub URL of current line' })
vim.keymap.set('n', '<leader>grb', '<Cmd>GBrowse<Cr>', { desc = 'View current file in Github' })

-- Git Rebase keymaps
vim.keymap.set('n', '<leader>grs', 'Git rebase --skip', { desc = 'Skip' })
vim.keymap.set('n', '<leader>grc', 'Git rebase --continue', { desc = 'Continue' })
vim.keymap.set('n', '<leader>gra', 'Git rebase --abort', { desc = 'Abort' })

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

-- Git keymaps
vim.keymap.set('n', '<leader>g<Space>', function() vim.fn.feedkeys(':Git ') end, { desc = ':Git' })
vim.keymap.set('n', '<leader>gl', function() require('neogit').open({ 'log' }) end, { desc = 'Log' })
vim.keymap.set('n', '<leader>gp', '<Cmd>Telescope gh pull_request<Cr>', { desc = 'Pull requests' })
vim.keymap.set('n', '<leader>gi', '<Cmd>Telescope gh issues assignee=@me search=-label:Epic<Cr>', { desc = 'Issues' })
vim.keymap.set('n', '<leader>gb', '<Cmd>Neogit branch<Cr>', { desc = 'Branches' })
vim.keymap.set('n', '<leader>gs', '<Cmd>TelescopeStash<Cr>', { desc = 'Stash' })
vim.keymap.set('n', '<leader>gc', '<Cmd>Neogit commit<Cr>', { desc = 'Commit' })
vim.keymap.set('n', '<leader>gL', '<Cmd>DiffviewFileHistory %<Cr>', { desc = 'Buffer commit history' })
vim.keymap.set('n', '<leader>gB', '<Cmd>Git blame<Cr>', { desc = 'Blame annotations' })
vim.keymap.set('n', '<leader>gg', '<Cmd>Neogit<Cr>', { desc = 'Git status' })

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
vim.keymap.set('n', '<leader>cD', '<Cmd>Trouble diagnostics toggle<Cr>', { desc = 'Workspace diagnostics' })
vim.keymap.set('n', '<leader>cs', '<Cmd>Trouble symbols focus<Cr>', { desc = 'Code symbols' })
vim.keymap.set('n', '<leader>cl', vim.diagnostic.open_float, { desc = 'Show diagnostics for current line' })
vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, { desc = 'Format' })
vim.keymap.set('n', '<leader>ch', vim.lsp.buf.hover, { desc = 'Hover' })
vim.keymap.set('n', '<leader>cg', vim.lsp.buf.signature_help, { desc = 'Signature help' })
vim.keymap.set('n', '<leader>ct', function() require('telescope.builtin').grep_string({ search = 'TODO|FIX|NOTE' }) end,
  { desc = 'Search TODO comments' })

-- Neotest keymaps
vim.keymap.set('n', '<leader>nt', function()
  vim.bo.buflisted = true
  require('neotest').run.run()
end, { desc = 'Run nearest' })
vim.keymap.set('n', '<leader>nf', function()
  vim.bo.buflisted = true
  require('neotest').run.run(vim.fn.expand('%'))
end, { desc = 'Run file' })
vim.keymap.set('n', '<leader>nd', function()
  vim.bo.buflisted = true
  require('neotest').run.run({ strategy = 'dap' })
end, { desc = 'Run with debugger' })
vim.keymap.set('n', '<leader>nl', function()
  vim.bo.buflisted = true
  require('neotest').run.run_last()
end, { desc = 'Run last' })
vim.keymap.set('n', '<leader>ns', function()
  vim.bo.buflisted = true
  require('neotest').summary.toggle()
end, { desc = 'Toggle summary' })
vim.keymap.set('n', '<leader>no', function()
  vim.bo.buflisted = true
  require('neotest').output_panel.toggle()
end, { desc = 'Toggle output panel' })

-- Terminal keymaps
--
vim.keymap.set('n', '<C-t><C-t>', function()
  local dir = utils.find_project_root() or vim.uv.cwd()
  vim.cmd.tabnew()
  require('termbuf.api').open_terminal({ dir })
end, { desc = 'Open terminal in new tab' })

vim.keymap.set('n', '<C-t><C-l>', function()
  local dir = utils.find_project_root() or vim.uv.cwd()
  vim.cmd.vsplit()
  require('termbuf.api').open_terminal({ dir })
end, { desc = 'Open terminal to right' })

vim.keymap.set('n', '<C-t><C-j>', function()
  local dir = utils.find_project_root() or vim.uv.cwd()
  vim.cmd('belowright split')
  require('termbuf.api').open_terminal({ dir })
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
  local oil = require('oil')
  vim.cmd.tabnew()
  oil.open()
end, { desc = 'Open file explorer' })
vim.keymap.set('n', '<leader>fr', function()
  local oil = require('oil')
  vim.cmd.tabnew()
  oil.open(utils.find_project_root())
end, { desc = 'Open file explorer from project root' })
vim.keymap.set('n', '<leader>fp', function()
  local oil = require('oil')
  local current_dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
  vim.cmd.tabnew()
  oil.open(current_dir)
end, { desc = 'Open file explorer from parent' })

-- Search and other keymaps
vim.keymap.set('n', '<leader>/', '<Cmd>Telescope current_buffer_fuzzy_find<Cr>', { desc = 'Search buffer' })
vim.keymap.set('n', '<leader>*', '<Cmd>Telescope grep_string<Cr>', { desc = 'Search for symbol globally' })
vim.keymap.set('n', '<leader>?', '<Cmd>Telescope live_grep<Cr>', { desc = 'Search globally' })
vim.keymap.set('n', '<leader>,', '<Cmd>TelescopeBuffers<Cr>', { desc = 'Switch buffer' })
vim.keymap.set('n', '<leader>.', function()
  require('telescope.builtin').git_files({ use_git_root = false, show_untracked = true })
end, { desc = 'Find file' })
vim.keymap.set('n', '<leader>\'', '<Cmd>Telescope marks<Cr>', { desc = 'List marks' })
vim.keymap.set('n', '<leader>;', '<Cmd>Telescope command_history<Cr>', { desc = 'List command history' })
