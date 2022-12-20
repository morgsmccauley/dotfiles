return {
  'williamboman/mason.nvim',
  after = 'neodev.nvim',
  requires = {
    { 'williamboman/mason-lspconfig.nvim' },
    { 'neovim/nvim-lspconfig' }
  },
  config = function()
    require('mason').setup()

    require('mason-lspconfig').setup {
      automatic_installation = true
    }
  end,
}
