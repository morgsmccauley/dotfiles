vim.g.mapleader = " "

local wk = require("which-key")

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
  A = { '1<C-w><C-w>:q<Cr><C-w><C-p>', 'Close first window' },
  a = { '1<C-w><C-w>', 'Go to first window' },
  S = { '2<C-w><C-w>:q<Cr><C-w><C-p>', 'Close second window' },
  s = { '2<C-w><C-w>', 'Go to second window' },
  D = { '3<C-w><C-w>:q<Cr><C-w><C-p>', 'Close second window' },
  d = { '3<C-w><C-w>', 'Go to third window' },
  F = { '4<C-w><C-w>:q<Cr><C-w><C-p>', 'Close second window' },
  f = { '4<C-w><C-w>', 'Go to fourth window' },
  J = { '5<C-w><C-w>:q<Cr><C-w><C-p>', 'Close second window' },
  j = { '5<C-w><C-w>', 'Go to fifth window' },
  K = { '6<C-w><C-w>:q<Cr><C-w><C-p>', 'Close second window' },
  k = { '6<C-w><C-w>', 'Go to sixth window' },
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

local diffview = {
  name = '+diffview',
  o = { ':DiffviewOpen<Cr>', 'Open' },
  c = { ':DiffviewClose<Cr>', 'Close' },
  b = { ':DiffviewOpen origin/master..HEAD<Cr>', 'Open (branch)' },
  f = { ':DiffviewToggleFiles', 'Toggle files' },
}

local git = {
  name = '+git',
  l = { ':lua require\'plugins/config/telescope-nvim\'.commits()<Cr>', 'Log' },
  p = { ':Telescope gh pull_request<Cr>', 'Pull requests' },
  i = { ':Telescope gh issues<Cr>', 'Issues' },
  b = { ':lua require\'plugins/config/telescope-nvim\'.branches()<Cr>', 'Branches' },
  s = { ':lua require\'plugins/config/telescope-nvim\'.stash()<Cr>', 'Stash' },
  c = { ':Neogit commit<Cr>', 'Commit' },
  L = { ':lua require\'plugins/config/telescope-nvim\'.bcommits()<Cr>', 'Buffer log' },
  B = { ':Git blame<Cr>', 'Blame annotations' },
  -- B = { ':Gitsigns toggle_current_line_blame<Cr>', 'Blame annotations' },
  g = { ':Neogit<Cr>', 'Git' },
  h = git_hunk,
  r = git_remote,
  R = git_rebase,
}

local session = {
  name = '+session',
  l = { ':Telescope session_manager load<Cr>', 'List sessions' },
  w = { ':SaveSession<Cr>', 'Write session' },
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
  a = { ':Telescope lsp_code_actions<Cr>', 'Code actions' },
  d = { ':Telescope diagnostics bufnr=0<Cr>', 'File diagnostics' },
  f = { ':lua vim.lsp.buf.formatting()<Cr>', 'Format' }
}

local hop = {
  name = '+hop',
  w = { ':HopWord<Cr>',  'Word' },
  l = { ':HopLine<Cr>',  'Line' },
  p = { ':HopPattern<Cr>', 'Pattern' },
  s = { ':HopChar1<Cr>', 'Single char' },
  d = { ':HopChar2<Cr>', 'Double char' },
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
  h = hop,
  j = jira,
  d = diffview,
  t = test,
  ['*'] = { ':Telescope grep_string<Cr>', 'Search for symbol globally' },
  ['/'] ={ ':Telescope live_grep<Cr>', 'Search globally' },
  [','] ={ ':lua require\'plugins/config/telescope-nvim\'.buffers()<Cr>', 'Switch buffer' },
  ['.'] = { ':Telescope git_files<Cr>', 'Find file' },
  ['\\'] = { ':luafile ~/.config/nvim/init.lua<Cr>', 'Reload config' },
}

local opts = {
  prefix = '<leader>'
}

wk.register(mappings, opts)
