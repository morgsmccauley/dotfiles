local lspconfig = require('lspconfig')

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename ${INPUT}",
  formatStdin = true
}

lspconfig.efm.setup {
  capabilities = capabilities,
  init_options = {
    documentFormatting = true
  },
  on_attach = function()
    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
  end,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = function(fname)
    return lspconfig.util.root_pattern(".eslintrc.js", ".git")(fname);
  end,
  settings = {
    rootMarkers = {".eslintrc.js", ".git/"},
    languages = {
      javascript = {eslint},
      typescript = {eslint},
      javascriptreact = {eslint},
      typescriptreact = {eslint},
    }
  }
}

lspconfig.tsserver.setup {
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
  end,
  flags = {
    debounce_text_changes = 150,
  }
}

lspconfig.rust_analyzer.setup {
  flags = {
    debounce_text_changes = 150,
  }
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup {
  capabilities = capabilities,
  cmd = {
    vim.fn.getenv('HOME') .. '/lua-language-server/bin/macOS/lua-language-server',
    '-E',
    vim.fn.getenv('HOME') ..'/lua-language-server/main.lua'
  };
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

require'lspconfig'.omnisharp.setup {
  cmd = {
   '/Users/morganmccauley/workspace/omnisharp-osx/run',
    '--languageserver',
    '--hostPID',
    tostring(vim.fn.getpid())
  }
}
