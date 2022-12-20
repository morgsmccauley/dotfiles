return {
  'folke/which-key.nvim',
  keys = { '<leader>', '"', '\'', '`' },
  config = function()
    require('plugins.tools.which-key.which-key')
  end
}
