vim.g.mapleader = ' '

local wk = require('which-key')

wk.setup {
  window = {
    border = 'single',
    margin = { 1, 0, 0, 0 },
    padding = { 2, 2, 2, 2 },
  },
}

local window = {
  name = '+window',
  q = { ':q<Cr>', 'Quit' },
  Q = { ':wq<Cr>', 'Save and quit' },
  w = { ':silent w<Cr>', 'Save' },
  r = { '<C-w>r', 'Rotate' },
  c = { '<Cmd>lua require("plugins/config/leap").leap_to_window()<Cr>', 'Choose window' },
  C = { '<Cmd>lua require("plugins/config/leap").close_window()<Cr>', 'Close target window' },
  o = { ':only<Cr>', 'Close all other windows' },
  l = { ':luafile %<Cr>', 'Source selected lua file' },
  v = { ':vsp<Cr>', 'Split window vertically' },
  ['='] = { '<C-w>=', 'Balance windows' },
  ['-'] = { '<C-w>|', 'Maximise window' }
}

local git_remote = {
  name = '+remote',
  p = { ':Neogit push<Cr>', 'Push' },
  u = { '!gpsup<Cr>', 'Push creating upstream' },
  l = { ':Neogit pull<Cr>', 'Pull' },
  f = { ':echo "Fetching remote..." | Git fetch<Cr>', 'Fetch' },
  y = { '<Plug>(gh-line)', 'Copy GitHub URL of current line' },
}

local git_rebase = {
  name = '+rebase',
  s = { 'Git rebase --skip', 'skip' },
  c = { 'Git rebase --continue', 'continue' },
  a = { 'Git rebase --abort', 'abort' },
}

local git_hunk = {
  name = '+hunk',
  s = { ':lua require\'gitsigns\'.stage_hunk()<Cr>', 'Stage' },
  u = { ':lua require\'gitsigns\'.undo_stage_hunk()<Cr>', 'Undo stage' },
  i = { ':lua require\'gitsigns\'.preview_hunk()<Cr>', 'Preview' },
  r = { ':lua require\'gitsigns\'.reset_hunk()<Cr>', 'Reset' },
  n = { ':lua require\'gitsigns\'.next_hunk()<Cr>', 'Next' },
  p = { ':lua require\'gitsigns\'.prev_hunk()<Cr>', 'Prev' },
}

local debug = {
  name = '+debug',
  n = { ':lua require"dap".step_over()<Cr>', 'Step over' },
  i = { ':lua require"dap".step_into()<Cr>', 'Step into' },
  o = { ':lua require"dap".step_out()<Cr>', 'Step out' },
  c = { ':lua require"dap".continue()<Cr>', 'Continue' },
  C = { ':lua require"dap".clear_breakpoints()<Cr>', 'Clear breakpoints' },
  s = { ':lua require"dap".terminate()<Cr>', 'Stop' },
  b = { ':lua require"dap".toggle_breakpoint()<Cr>', 'Toggle breakpoint' },
  B = { ':lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<Cr>', 'Set breakpoint with condition' },
  r = {
    function()
      require('dap').repl.toggle()
      -- wasn't able to make this work in lua - win_findbuf[0] returned nil
      vim.api.nvim_command "call win_gotoid(win_findbuf(bufnr('dap-repl'))[0])"
    end,
    'Toggle repl'
  },
  u = { ':lua require"dapui".toggle()<Cr>', 'Toggle ui' }
}

local git_diff = {
  name = '+diff',
  o = { ':DiffviewOpen<Cr>', 'Open' },
  b = { ':DiffviewOpen master...HEAD<Cr>', 'Open (branch)' },
  c = { ':DiffviewClose<Cr>', 'Close' },
  f = { ':DiffviewToggleFiles<Cr>', 'Toggle files pane' }
}

local git = {
  name = '+git',
  l = { ':lua require\'plugins/config/telescope-nvim\'.commits()<Cr>', 'Log' },
  p = { ':Telescope gh pull_request<Cr>', 'Pull requests' },
  i = { ':Telescope gh issues<Cr>', 'Issues' },
  b = { ':lua require\'plugins/config/telescope-nvim\'.branches()<Cr>', 'Branches' },
  s = { ':lua require\'plugins/config/telescope-nvim\'.stash()<Cr>', 'Stash' },
  c = { ':Git commit<Cr>', 'Commit' },
  L = { ':lua require\'plugins/config/telescope-nvim\'.bcommits()<Cr>', 'Buffer log' },
  B = { ':Git blame<Cr>', 'Blame annotations' },
  g = { ':Git<Cr>', 'Git' },
  h = git_hunk,
  d = git_diff,
  r = git_remote,
  R = git_rebase,
}

local session = {
  name = '+session',
  -- require telescope since it's lazy loaded
  l = { ':lua require("telescope") require("session_manager").load_session()<Cr>', 'List sessions' },
  w = { ':SaveSession<Cr>', 'Write session' },
  d = { ':lua requrie("telescope") require("session_manager").delete_session()<Cr>', 'Delete session(s)' },
}

local marks = {
  name = '+marks',
  D = { ':delmarks!<Cr>', 'Delete all marks for current buffer' },
  m = { ':norm\'<Cr>', 'List marks' }
}

local buffer = {
  name = '+buffer',
  e = { ':edit<Cr>', 'Edit buffer' },
  y = { ':let @* = expand("%")<Cr>', 'Yank filename' }
}

local code = {
  name = '+code',
  -- c = { ':Telescope commands<Cr>', 'Commands' },
  a = { ':lua vim.lsp.buf.code_action()<Cr>', 'Code actions' },
  d = { ':Telescope diagnostics bufnr=0<Cr>', 'File diagnostics' },
  D = { ':Telescope diagnostics<Cr>', 'Workspace diagnostics' },
  l = { ':lua vim.diagnostic.open_float()<Cr>', 'Show diagnostics for current line' },
  f = { ':lua vim.lsp.buf.format()<Cr>', 'Format' }
}

local jira = {
  name = '+jira',
  l = { ':lua require\'plugins/config/telescope-nvim\'.jira()<Cr>', 'List Issues' }
}

local test = {
  name = '+test',
  f = { ':TestFile<Cr>', 'Test file' },
  l = { ':TestLast<Cr>', 'Test last' },
  t = { ':TestNearest<Cr>', 'Test under cursor' },
  s = { ':TestSuite<Cr>', 'Test suite' }
}

local mappings = {
  w = window,
  g = git,
  s = session,
  m = marks,
  b = buffer,
  c = code,
  j = jira,
  d = debug,
  t = test,
  ['*'] = { ':Telescope grep_string<Cr>', 'Search for symbol globally' },
  ['/'] = { ':Telescope live_grep<Cr>', 'Search globally' },
  [','] = { ':lua require\'plugins/config/telescope-nvim\'.buffers()<Cr>', 'Switch buffer' },
  ['.'] = { ':Telescope git_files<Cr>', 'Find file' },
  ['\\'] = { ':Telescope current_buffer_fuzzy_find<Cr>', 'Fuzzy find current buffer' },
  ['\''] = { ':Telescope marks<Cr>', 'List marks' },
}

local opts = {
  prefix = '<leader>'
}

wk.register(mappings, opts)
