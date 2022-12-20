return {
  'ruanyl/vim-gh-line',
  config = function()
    vim.g.gh_line_map_default = 0
    vim.g.gh_line_blame_map_default = 0
    vim.g.gh_open_command = 'fn() { echo "$@" | pbcopy; }; fn '
    vim.g.gh_use_canonical = 0
  end
}
