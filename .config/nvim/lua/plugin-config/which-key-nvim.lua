vim.g.mapleader = " "

local wk = require("which-key")

wk.setup {
  window = {
    margin = { 1, 0, 0, 0 },
    padding = { 2, 2, 2, 2 },
  },
}

local window = {
  name = '+window',
  q = { ':q<Cr>', 'Quit' },
  Q = { ':wq<Cr>', 'Save and quit' },
  w = { ':w<Cr>', 'Save' },
  r = { '<C-w>r', 'Rotate' },
  a = { '1<C-w><C-w>', 'Go to first window' },
  s = { '2<C-w><C-w>', 'Go to second window' },
  d = { '3<C-w><C-w>', 'Go to third window' },
  f = { '4<C-w><C-w>', 'Go to fourth window' },
  j = { '5<C-w><C-w>', 'Go to fifth window' },
  k = { '6<C-w><C-w>', 'Go to sixth window' },
  D = { ':only<Cr>', 'Close all other windows' },
  l = { ':luafile %<Cr>', 'Source selected lua file' },
  ['='] = { '<C-w>=', 'Balance windows' }
}

local git_remote = {
  name = '+remote',
  p = { ':echo "Pushing to remote..." | Git push<Cr>', 'Push' },
  P = {
    function()
      local confirm = vim.fn.input'Force push to remote? [Y/n] '
      if string.lower(confirm) ~= 'y' then return end

      vim.api.nvim_command'Git push --force-with-lease'
    end,
    'Force push'
  },
  u = { '!gpsup<Cr>', 'Push creating upstream' },
  l = { ':echo "Pulling from remote..." | Git pull<Cr>', 'Pull' },
  f = { ':echo "Fetching remote..." | Git fetch<Cr>', 'Fetch' },
  y = { ':CocCommand git.copyUrl<Cr>', 'Copy GitHub URL of current line' },
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

local git = {
  name = '+git',
  l = { ':lua require\'plugin-config/telescope-nvim\'.commits()<Cr>', 'Log' },
  p = { ':Telescope gh pull_request<Cr>', 'Pull requests' },
  b = { ':lua require\'plugin-config/telescope-nvim\'.branches()<Cr>', 'Branches' },
  s = { ':call GitStash()<Cr>', 'Stash' },
  L = { ':Telescope git_bcommits<Cr>', 'Buffer log' },
  B = { ':Git blame<Cr>', 'Blame annotations' },
  -- B = { ':lua require\'gitsigns\'.blame_line()<Cr>', 'Blame annotations' },
  g = { ':Git<Cr>', 'Git' },
  h = git_hunk,
  r = git_remote,
  R = git_rebase,
}

local session = {
  name = '+session',
  l = { ':Telescope session_manager load<Cr>', 'List sessions' },
  w = { ':SaveSession<Cr>', 'Write session' },
}

local mappings = {
  w = window,
  g = git,
  s = session,
  ['*'] = { 'yiw:Rg <C-r>+<Cr>', 'Search for symbol globally' },
  ['/'] ={ ':silent Rg<Cr>', 'Search globally' },
  [','] ={ ':lua require\'plugin-config/telescope-nvim\'.buffers()<Cr>', 'Switch buffer' },
  ['.'] = { ':Telescope git_files<Cr>', 'Find file' },
  ['\\'] = { ':luafile ~/.config/nvim/init.lua<Cr>', 'Reload config' }
}

local opts = {
  prefix = '<leader>'
}

wk.register(mappings, opts)
