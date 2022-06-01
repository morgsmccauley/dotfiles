local lspconfig = require('lspconfig')

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

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
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  }
}

--[[ local runtime_path = vim.split(package.path, ';')
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
        globals = {'vim', 'hs'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
} ]]
