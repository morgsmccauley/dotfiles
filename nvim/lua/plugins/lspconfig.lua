return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'b0o/SchemaStore.nvim',
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

    -- TODO: Use https://github.com/fsouza/prettierd?tab=readme-ov-file#local-instance so that locally installed
    -- prettier instances are used?
    lspconfig.efm.setup {
      init_options = { documentFormatting = true },
      filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
      root_dir = function(fname)
        return vim.fs.root(fname, {
          '.prettierrc',
          '.prettierrc.js',
          '.prettierrc.cjs',
          '.prettierrc.json',
          '.prettierrc.yaml',
          '.prettierrc.yml',
          '.prettierrc.toml',
        })
      end,
      settings = {
        languages = {
          javascript = {
            { formatCommand = 'prettier ${INPUT}', formatStdin = true },
          },
          typescript = {
            { formatCommand = 'prettier ${INPUT}', formatStdin = true },
          },
          javascriptreact = {
            { formatCommand = 'prettier ${INPUT}', formatStdin = true },
          },
          typescriptreact = {
            { formatCommand = 'prettier ${INPUT}', formatStdin = true },
          },
        },
      },
      on_attach = function(_client, bufnr)
        vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
          buffer = bufnr,
          callback = function() vim.lsp.buf.format({ async = false }) end,
        })
      end
    }

    lspconfig.ts_ls.setup {
      init_options = {
        documentFormatting = false,
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
          schemaStore = {
            -- You must disable built-in schemaStore support if you want to use
            -- this plugin and its advanced options like `ignore`.
            enable = false,
            -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
            url = "",
          },
          schemas = require('schemastore').yaml.schemas(),
        },
      },
    }
  end
}
