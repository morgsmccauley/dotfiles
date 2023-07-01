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
    local fmt = require('luasnip.extras.fmt').fmt

    local snippet = luasnip.snippet
    local text = luasnip.text_node
    local insert = luasnip.insert_node
    local fn = luasnip.function_node

    luasnip.setup({
      history = true,
      update_events = 'TextChanged,TextChangedI',
    })

    luasnip.filetype_extend('typescript', { 'javascript' })

    require('luasnip.loaders.from_snipmate').lazy_load({ paths = { './lua/plugins/luasnip/snippets' } })
    -- require('luasnip.loaders.from_lua').lazy_load({ paths = { vim.fn.stdpath('config') .. '/lua' } })

    local function get_variable_name()
      local parser = vim.treesitter.get_parser(0, "javascript")
      local query = vim.treesitter.query.parse("javascript", "(variable_declarator (identifier) @id)")

      local cursor = vim.api.nvim_win_get_cursor(0)
      local row = cursor[1]

      for _, tree in pairs(parser:parse()) do
        for _, match in query:iter_captures(tree:root(), 0, row - 2, row - 1) do
          return vim.treesitter.get_node_text(match, 0)
        end
      end

      return ''
    end

    luasnip.add_snippets('all', {
      snippet(
        'clv',
        fmt(
          [[console.log({{ {} }})]],
          {
            fn(get_variable_name)
          }
        )
      ),
      snippet(
        "r",
        fmt(
          [[local {} = require('{}')]],
          {
            fn(function(args)
              local parts = vim.split(args[1][1], '.', true)
              return parts[#parts] or ''
            end, { 1 }),
            insert(1)
          }
        )
      ),
    })
  end,
}
