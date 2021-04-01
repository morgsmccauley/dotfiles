vim.g.startify_session_sort = 1
vim.g.startify_change_to_dir = 0
vim.g.startify_change_to_vcs_root = 1
vim.g.startify_session_persistence = 1
vim.g.startify_session_autoload = 1
vim.g.startify_disable_at_vimenter = 1
vim.g.startify_session_before_save = {
  'echo "Cleaning up before saving..."',
  'silent! NvimTreeClose',
  'silent! call MonkeyTerminalQuit()',
}
