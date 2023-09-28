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
    },
    {
      '<C-j>',
      function()
        local luasnip = require 'luasnip'
        luasnip.change_choice(1)
      end,
      mode = { 'i', 's' },
      { noremap = true, silent = true }
    },
    {
      '<C-k>',
      function()
        local luasnip = require 'luasnip'
        luasnip.change_choice(-1)
      end,
      mode = { 'i', 's' },
      { noremap = true, silent = true }
    },
  },
  config = function()
    local luasnip = require('luasnip')

    luasnip.setup({
      history = true,
      update_events = 'TextChanged,TextChangedI',
    })

    luasnip.filetype_extend('typescript', { 'javascript' })
    luasnip.filetype_extend('NeogitCommitMessage', { 'gitcommit' })

    require('luasnip.loaders.from_lua').lazy_load({ paths = { './lua/plugins/luasnip/snippets/lua' } })
    require('luasnip.loaders.from_snipmate').lazy_load({ paths = { './lua/plugins/luasnip/snippets/snipmate' } })
  end,
}
