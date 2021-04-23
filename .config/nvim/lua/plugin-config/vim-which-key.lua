vim.g.mapleader = " "

local whichkey = require('whichkey_setup')

local window = {
  name = '+window',
  q = { ':q<Cr>', 'Quit' },
  Q = { ':wq<Cr>', 'Save and quit' },
  w = { ':w<Cr>', 'Save' },
  D = { ':only<Cr>', 'Close all other windows' },
  l = { ':luafile %<Cr>', 'Source selected lua file' },
}
window['='] = { '<C-w>=', 'Balance windows' }

local git_remote = {
  name = '+remote',
  p = { ':echo "Pushing to remote..." | Git push<Cr>', 'Push' },
  P = { ':echo "Force pushing to remote..." | Git push --force-with-lease<Cr>', 'Force push' },
  u = { '!gpsup<Cr>', 'Push creating upstream' },
  l = { ':echo "Pulling from remote..." | Git pull<Cr>', 'Pull' },
  f = { ':echo "Fetching remote..." | Git fetch<Cr>', 'Fetch' },
  y = { ':CocCommand git.copyUrl', 'Copy GitHub URL of current line' },
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
  l = { ':call GitLog()<Cr>', 'Log' },
  p = { ':call GitPullRequest()<Cr>', 'Pull requests' },
  b = { ':call GitBranch()<Cr>', 'Branches' },
  s = { ':call GitStash()<Cr>', 'Stash' },
  L = { ':BCommits<Cr>', 'Buffer log' },
  --lua require\'gitsigns\'.blame_line()<CR>
  B = { ':Git blame<Cr>', 'Blame annotations' },
  -- B = { ':lua require\'gitsigns\'.blame_line()<Cr>', 'Blame annotations' },
  g = { ':Git<Cr>', 'Git' },
  --h doesnt work???
  h = git_hunk,
  r = git_remote,
  R = git_rebase,
}
git['['] = { '<plug>(GitGutterPrevHunk)', 'Go to prev hunk' }
git[']'] = { '<plug>(GitGutterNextHunk)', 'Go to next hunk' }

local session = {
  name = '+session',
  l = { ':call Sessions()<Cr>', 'List sessions' },
  q = { ':SClose<Cr>', 'Quit session' },
  w = { ':SSave<Cr>', 'Write session' },
}

local keymap = {
  w = window,
  g = git,
  s = session,
}
-- need to manually set these as '.' is slow through which-key
keymap['*'] = 'Search for symbol globally'
vim.api.nvim_set_keymap('n', '<leader>*', 'yiw:Rg <C-r>+<Cr>', { noremap = true })

keymap['/'] = 'Search globally'
vim.api.nvim_set_keymap('n', '<leader>/', ':silent Rg<Cr>', { noremap = true })

keymap[','] = 'Switch buffer'
vim.api.nvim_set_keymap('n', '<leader>,', ':silent Buffers<Cr>', { noremap = true })

keymap['.'] = 'Find file'
vim.api.nvim_set_keymap('n', '<leader>.', ':silent GitFiles<Cr>', { noremap = true })

keymap['\\'] = 'Reload config'
vim.api.nvim_set_keymap('n', '<leader>\\', ':luafile ~/.config/nvim/init.lua<Cr>', { noremap = true })

whichkey.register_keymap('leader', keymap)
