return {
  {
    'hrsh7th/cmp-nvim-lsp',
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'onsails/lspkind.nvim',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
      {
        'hrsh7th/cmp-cmdline',
        keys = {
          { ';', ':', { noremap = true, silent = true } }
        },
        config = function()
          local cmp = require 'cmp'
          cmp.setup.cmdline(':', {
            -- TODO reverse order
            mapping = cmp.mapping.preset.cmdline({
              ['<CR>'] = {
                -- TODO auto CR after selecting
                c = cmp.mapping.confirm({ select = true })
              },
              ['<C-j>'] = {
                c = cmp.mapping.select_next_item()
              },
              ['<C-k>'] = {
                c = cmp.mapping.select_prev_item()
              }
            }),
            sources = cmp.config.sources(
              {
                { name = 'path' }
              },
              {
                {
                  name = 'cmdline',
                  option = {
                    ignore_cmds = { 'Man', '!' }
                  }
                }
              }
            )
          })
        end
      }
    },
    init = function()
      vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })
    end,
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
          --[[ ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(), ]]
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          ['<C-j>'] = cmp.mapping.select_next_item(),
          -- currently this is used to go to end of line
          ['<C-e>'] = cmp.mapping.close(),
          ['<C-y>'] = cmp.mapping.confirm({
            behaviour = cmp.ConfirmBehavior.Replace,
            select = true
          }),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<CR>'] = cmp.mapping.confirm({
            behaviour = cmp.ConfirmBehavior.Insert,
            select = true
          }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<Tab>'] = cmp.mapping.disable
          --[[ ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }), ]]
        },
        sources = {
          { name = 'copilot' },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path',    max_item_count = 10 },
          { name = 'buffer',  max_item_count = 10 },
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol_text',
            symbol_map = { Copilot = '' }
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
}
