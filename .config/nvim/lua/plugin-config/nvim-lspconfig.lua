require'lspconfig'.tsserver.setup {}
require'lspconfig'.cssls.setup {}
require'lspconfig'.html.setup {}
require'lspconfig'.rust_analyzer.setup {}

local sumneko_path = '/Users/morganmccauley/lua-language-server'
require'lspconfig'.sumneko_lua.setup {
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

vim.g.completion_matching_smart_case = 1
vim.g.completion_sorting = 'length'
vim.g.completion_matching_strategy_list = {'fuzzy'}
