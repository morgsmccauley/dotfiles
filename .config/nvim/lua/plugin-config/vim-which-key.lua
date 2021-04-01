local whichkey = require('whichkey_setup')

local window = {
  name = '+window',
  q = { ':q<Cr>', 'Quit' },
  Q = { ':wq<Cr>', 'Save and quit' },
  w = { ':w<Cr>', 'Save' },
  D = { ':only<Cr>', 'Close all other windows' },
}
window['='] = { '<C-w>=', 'Balance windows' }

local git_remote = {
  name = '+remote',
  p = { ':echo "Pushing to remote..." | Git push', 'Push' },
  P = { ':echo "Force pushing to remote..." | Git push --force-with-lease', 'Force push' },
  u = { '!gpsup', 'Push creating upstream' },
  l = { ':echo "Pulling from remote..." | Git pull', 'Pull' },
  f = { ':echo "Fetching remote..." | Git fetch', 'Fetch' },
  y = { ':CocCommand git.copyUrl', 'Copy GitHub URL of current line' },
}

local git_rebase = {
  name = '+rebase',
  s = { 'Git rebase --skip', 'skip' },
  c = { 'Git rebase --continue', 'continue' },
  a = { 'Git rebase --abort', 'abort' },
}

local git = {
  name = '+git',
  l = { ':call GitLog()<Cr>', 'Log' },
  p = { ':call GitPullRequest()<Cr>', 'Pull requests' },
  b = { ':call GitBranch()<Cr>', 'Branches' },
  s = { ':call GitStash()<Cr>', 'Stash' },
  L = { ':BCommits<Cr>', 'Buffer log' },
  i = { '<plug>(GitGutterPreviewHunk)', 'Preview hunk' },
  u = { '<plug>(GitGutterUndoHunk)', 'Undo hunk' },
  B = { ':Gblame<Cr>', 'Blame annotations' },
  C = { ':CocCommand git.showCommit', 'Show commit' },
  g = { ':Git<Cr>', 'Git' },
  r = git_remote,
  R = git_rebase,
}
git['['] = { '<plug>(GitGutterPrevHunk)', 'Go to prev hunk' }
git[']'] = { '<plug>(GitGutterNextHunk)', 'Go to next hunk' }

local keymap = {
  w = window,
  g = git,
  h = { name = 'hi' },
}
-- need to manually set these as '.' is slow through which-key
vim.api.nvim_set_keymap('n', '<leader>*', 'yiw:Rg <C-r>+<Cr>', { noremap = true })
keymap['*'] = 'Search for symbol globally'
vim.api.nvim_set_keymap('n', '<leader>*', 'yiw:Rg <C-r>+<Cr>', { noremap = true })
keymap['/'] = 'Search globally'
vim.api.nvim_set_keymap('n', '<leader>,', ':Buffers<Cr>', { noremap = true })
keymap[','] = 'Switch buffer'
vim.api.nvim_set_keymap('n', '<leader>.', ':GitFiles<Cr>', { noremap = true })
keymap['.'] = 'Find file'
vim.api.nvim_set_keymap('n', '<leader>\\', ':luafile ~/.config/nvim/init.lua<Cr>', { noremap = true })
keymap['\\'] = 'Reload config'

whichkey.register_keymap('leader', keymap)
