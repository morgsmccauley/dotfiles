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

-- vim.lsp.config.util.default_config = vim.tbl_extend(
--   'force',
--   vim.lsp.config.util.default_config,
--   {
--     handlers = {
--       ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
--       ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
--     },
--   }
-- )

-- TODO: Use https://github.com/fsouza/prettierd?tab=readme-ov-file#local-instance so that locally installed
-- prettier instances are used?
vim.lsp.config.efm = {
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
        { formatCommand = 'prettier --stdin-filepath ${INPUT}', formatStdin = true },
      },
      typescript = {
        { formatCommand = 'prettier --stdin-filepath ${INPUT}', formatStdin = true },
      },
      javascriptreact = {
        { formatCommand = 'prettier --stdin-filepath ${INPUT}', formatStdin = true },
      },
      typescriptreact = {
        { formatCommand = 'prettier --stdin-filepath ${INPUT}', formatStdin = true },
      },
    },
  },
  on_attach = function(_client, bufnr)
    local augroup = vim.api.nvim_create_augroup('LspFormatting_' .. bufnr, { clear = true })
    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({
          async = false,
          timeout_ms = 2000,
          filter = function(client)
            return client.name == "efm"
          end
        })
      end,
    })
  end
}

vim.lsp.config.ts_ls = {
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

vim.lsp.config.lua_ls = {
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

vim.lsp.config.eslint = {
  on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
      buffer = bufnr,
      command = 'EslintFixAll'
    })
  end
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.config.jsonls = {
  capabilities,
  settings = {
    json = {
--      schemas = require('schemastore').json.schemas(),
--      validate = { enable = true },
    },
  },
}

-- provides better diagnostics
-- lspconfig.terraform_lsp.setup {}

-- -- provides go to definition and hover support
-- vim.lsp.config.terraformls = {
--   on_attach = function(client, bufnr)
--     -- client.server_capabilities.semanticTokensProvider = false

--     vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
--       buffer = bufnr,
--       callback = function() vim.lsp.buf.format({ async = false }) end,
--     })
--   end
-- }

vim.lsp.config.yamlls = {
  settings = {
    yaml = {
--      schemaStore = {
--        -- You must disable built-in schemaStore support if you want to use
--        -- this plugin and its advanced options like `ignore`.
--        enable = false,
--        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
--        url = "",
--      },
--      schemas = require('schemastore').yaml.schemas(),
    },
  },
}

-- Enable all configured LSP servers
vim.lsp.enable({ 'efm', 'ts_ls', 'lua_ls', 'eslint', 'jsonls', 'yamlls' })
