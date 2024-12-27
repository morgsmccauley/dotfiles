return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'b0o/SchemaStore.nvim',
    {
      'williamboman/mason-lspconfig.nvim',
      config = function()
        -- needs to be before lspconfig setup
        require('mason-lspconfig').setup {
          automatic_installation = false
        }
      end,
    },
  },
  config = function()
    local lspconfig = require('lspconfig')

    local border = {
      { '╭', 'FloatBorder' },
      { '─', 'FloatBorder' },
      { '╮', 'FloatBorder' },
      { '│', 'FloatBorder' },
      { '╯', 'FloatBorder' },
      { '─', 'FloatBorder' },
      { '╰', 'FloatBorder' },
      { '│', 'FloatBorder' },
    }

    lspconfig.util.default_config = vim.tbl_extend(
      'force',
      lspconfig.util.default_config,
      {
        handlers = {
          ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
          ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
        },
      }
    )

    lspconfig.efm.setup {
      init_options = { documentFormatting = true },
      filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
      settings = {
        rootMarkers = { '.git/' },
        languages = {
          javascript = {
            { formatCommand = 'prettierd ${INPUT}', formatStdin = true },
          },
          typescript = {
            { formatCommand = 'prettierd ${INPUT}', formatStdin = true },
          },
          javascriptreact = {
            { formatCommand = 'prettierd ${INPUT}', formatStdin = true },
          },
          typescriptreact = {
            { formatCommand = 'prettierd ${INPUT}', formatStdin = true },
          },
        },
      },
    }

    lspconfig.ts_ls.setup {
      init_options = {
        preferences = {
          disableSuggestions = true,
        },
      },
      on_attach = function(client)
        -- client.server_capabilities.semanticTokensProvider = false
        client.server_capabilities.document_formatting = false
      end,
      flags = {
        debounce_text_changes = 150,
      }
    }

    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          }
        }
      },
      on_attach = function(client, bufnr)
        -- client.server_capabilities.semanticTokensProvider = false

        vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
          buffer = bufnr,
          callback = function() vim.lsp.buf.format({ async = false }) end,
        })
      end
    }

    lspconfig.eslint.setup {
      on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
          buffer = bufnr,
          command = 'EslintFixAll'
        })
      end
    }

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    lspconfig.jsonls.setup {
      capabilities,
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
    }

    lspconfig.graphql.setup {
      filetypes = { 'graphql', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }
    }

    -- provides better diagnostics
    -- lspconfig.terraform_lsp.setup {}

    -- provides go to definition and hover support
    lspconfig.terraformls.setup {
      on_attach = function(client, bufnr)
        -- client.server_capabilities.semanticTokensProvider = false

        vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
          buffer = bufnr,
          callback = function() vim.lsp.buf.format({ async = false }) end,
        })
      end
    }

    lspconfig.yamlls.setup {
      settings = {
        yaml = {
          schemas = require('schemastore').yaml.schemas(),
        },
      },
    }

    lspconfig.rnix.setup {}


    lspconfig.buf_ls.setup {}
  end
}
