local lspconfig = require('lspconfig')

lspconfig.tsserver.setup {}
lspconfig.cssls.setup {}
lspconfig.html.setup {}
lspconfig.rust_analyzer.setup {}

local sumneko_path = '/Users/morganmccauley/lua-language-server'
lspconfig.sumneko_lua.setup {
  -- name = 'Lua', -- breaks everything
  cmd = {sumneko_path..'/bin/macOS/lua-language-server', '-E', sumneko_path..'/main.lua'},
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

local filetypes = {
    typescript = "eslint",
    javascript = "eslint",
    typescriptreact = "eslint",
    javascriptreact = "eslint",
}
local linters = {
    eslint = {
        sourceName = "eslint",
        command = "eslint", -- not ideal using global
        rootPatterns = {".eslintrc.js", "package.json"},
        debounce = 100,
        args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
        parseJson = {
            errorsRoot = "[0].messages",
            line = "line",
            column = "column",
            endLine = "endLine",
            endColumn = "endColumn",
            message = "${message} [${ruleId}]",
            security = "severity"
        },
        securities = {[2] = "error", [1] = "warning"}
    }
}

local formatters = {
    eslint = {command = "eslint", args = {"--fix", "--stdin", "--stdin-filepath", "%filepath"}},
}

lspconfig.diagnosticls.setup {
    filetypes = vim.tbl_keys(filetypes),
    init_options = {
        filetypes = filetypes,
        linters = linters,
        formatters = formatters,
        formatFiletypes = filetypes
    }
}

vim.cmd [[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]]

-- lua vim.lsp.diagnostic.show_line_diagnostics()
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false
    }
)
