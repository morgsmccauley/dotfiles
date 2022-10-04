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
    client.server_capabilities.document_formatting = false
  end,
  flags = {
    debounce_text_changes = 150,
  }
}

lspconfig.sumneko_lua.setup {
  capabilities = capabilities,
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
      callback = vim.lsp.buf.formatting_sync,
    })
  end
}

lspconfig.eslint.setup {}

lspconfig.jsonls.setup {
  capabilities = capabilities
}
