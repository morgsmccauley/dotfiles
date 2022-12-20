return {
  'williamboman/mason.nvim',
  after = 'neodev.nvim',
  requires = {
    { 'williamboman/mason-lspconfig.nvim' },
    { 'neovim/nvim-lspconfig' }
  },
  config = function()
    require('plugins.lsp.mason.mason')
  end,
}
