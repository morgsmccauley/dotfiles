return {
    'hrsh7th/nvim-cmp',
    after = 'lspkind.nvim',
    requires = {
        {
            'onsails/lspkind.nvim',
            after = 'LuaSnip',
        },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-path',         after = 'nvim-cmp' },
        { 'hrsh7th/cmp-buffer',       after = 'nvim-cmp' },
        { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local lspkind = require 'lspkind'

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
      end

      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup {
          --[[ completion = {
        autocomplete = true,
      }, ]]
          snippet = {
              expand = function(args)
                luasnip.lsp_expand(args.body)
              end,
          },
          mapping = {
              ['<C-p>'] = cmp.mapping.select_prev_item(),
              ['<C-n>'] = cmp.mapping.select_next_item(),
              ['<C-e>'] = cmp.mapping.scroll_docs( -4),
              ['<C-y>'] = cmp.mapping.scroll_docs(4),
              ['<CR>'] = cmp.mapping.confirm({ select = true }),
              ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                elseif has_words_before() then
                  cmp.complete()
                else
                  fallback()
                end
              end, { 'i', 's' }),

              ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.jumpable( -1) then
                  luasnip.jump( -1)
                else
                  fallback()
                end
              end, { 'i', 's' }),
          },
          sources = {
              { name = 'nvim_lsp', max_item_count = 20 },
              { name = 'path',     max_item_count = 10 },
              { name = 'buffer',   max_item_count = 10 },
              { name = 'luasnip' },
          },
          formatting = {
              format = lspkind.cmp_format({
                  mode = 'symbol_text'
              })
          },
          window = {
              completion = cmp.config.window.bordered(),
              documentation = cmp.config.window.bordered(),
          },
          complete_opt = 'menu,menuone,noinsert',
          experimental = {
              ghost_text = true,
          }
      }
    end,
}
