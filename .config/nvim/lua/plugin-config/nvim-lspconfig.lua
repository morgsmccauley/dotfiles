local lspconfig = require('lspconfig')

local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename ${INPUT}",
  formatStdin = true
}

lspconfig.efm.setup {
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

-- lspconfig.graphql.setup{}

--[[ local pid = vim.fn.getpid()
-- On linux/darwin if using a release build, otherwise under scripts/OmniSharp(.Core)(.cmd)
local omnisharp_bin = '/Users/morganmccauley/workspace/omnisharp-osx/run'
-- on Windows
-- local omnisharp_bin = "/path/to/omnisharp/OmniSharp.exe"
require'lspconfig'.omnisharp.setup{
    cmd = { omnisharp_bin, '--languageserver' , '--hostPID', tostring(pid) };
    ...
} ]]
