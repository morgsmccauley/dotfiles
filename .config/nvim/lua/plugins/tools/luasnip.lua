return {
  'L3MON4D3/LuaSnip',
  after = 'friendly-snippets',
  config = function()
    require 'luasnip'.filetype_extend('typescript', { 'javascript' })
  end,
  requires = {
    {
      'rafamadriz/friendly-snippets',
      event = 'InsertEnter',
    }
  }
}
