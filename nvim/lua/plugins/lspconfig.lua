return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'b0o/SchemaStore.nvim'
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

    lspconfig.tsserver.setup {
      init_options = {
        preferences = {
          disableSuggestions = true,
        },
      },
      on_attach = function(client)
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
      on_attach = function(_, bufnr)
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

    lspconfig.jsonls.setup {
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
  end
}
