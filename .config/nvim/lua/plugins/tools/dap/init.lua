return {
  'mfussenegger/nvim-dap',
  module = 'dap',
  requires = {
    'nvim-telescope/telescope-dap.nvim'
  },
  config = function()
    require('plugins.tools.dap.dap')

  end
}
