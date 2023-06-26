return {
  'L3MON4D3/LuaSnip',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  event = 'InsertEnter',
  keys = {
    {
      '<C-l>',
      function()
        local luasnip = require 'luasnip'
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        end
      end,
      mode = { 'i', 's' },
      { noremap = true, silent = true }
    },
    {
      '<C-h>',
      function()
        local luasnip = require 'luasnip'
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end,
      mode = { 'i', 's' },
      { noremap = true, silent = true }
    }
  },
  config = function()
    local luasnip = require('luasnip')

    luasnip.setup({
      history = true,
      update_events = 'TextChanged,TextChangedI',
    })

    luasnip.filetype_extend('typescript', { 'javascript' })

    require('luasnip.loaders.from_snipmate').lazy_load({ paths = { '~/.config/nvim/snippets' } })
  end,
}
