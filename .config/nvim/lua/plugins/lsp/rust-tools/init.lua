return {
  'simrat39/rust-tools.nvim',
  ft = 'rust',
  config = function()
    require('plugins.lsp.rust-tools.rust-tools')
  end
}
