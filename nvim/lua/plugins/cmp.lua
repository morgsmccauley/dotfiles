return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'onsails/lspkind.nvim',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'saadparwaiz1/cmp_luasnip',
    {
      'hrsh7th/cmp-nvim-lsp',
      config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local lspconfig = require('lspconfig')

        lspconfig.util.default_config = vim.tbl_extend(
          'force',
          lspconfig.util.default_config,
          {
            capabilities = capabilities,
          }
        )
      end
    },
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
            ['<Cr>'] = {
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
    },
    {
      'kristijanhusak/vim-dadbod-completion',
      config = function()
        vim.api.nvim_create_autocmd({ 'FileType' }, {
          pattern = { 'sql', 'mysql', 'pgsql', 'plsql' },
          callback = function()
            require('cmp').setup.buffer({ sources = { { name = 'vim-dadbod-completion' } } })
          end
        })
      end
    }
  },
  init = function()
    vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })
  end,
  config = function()
    local cmp = require 'cmp'

    cmp.setup {
      --[[ completion = {
          autocomplete = true,
        }, ]]
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      mapping = {
        --[[ ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(), ]]
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        -- currently this is used to go to end of line
        ['<C-e>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.abort()
          else
            fallback()
          end
        end),
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
      },
      sources = {
        { name = 'copilot' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path',    max_item_count = 10 },
        { name = 'buffer',  max_item_count = 10 },
      },
      formatting = {
        format = require('lspkind').cmp_format({
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
