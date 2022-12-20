return {
  'hrsh7th/nvim-cmp',
  after = 'lspkind.nvim',
  requires = {
    {
      'onsails/lspkind.nvim',
      event = 'InsertEnter',
    },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
    { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
  },
  config = function()
    require('plugins.ui.cmp.cmp')
  end,
}
