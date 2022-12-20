return {
  'akinsho/toggleterm.nvim',
  cmd = { 'ToggleTerm', 'TermExec' },
  config = function()
    require('plugins.tools.toggleterm.toggleterm')
  end
}
