require("nvim-lsp-installer").setup {
  ensure_installed = {
    'tsserver',
    'sumneko_lua',
    'rust_analyzer',
    'eslint'
  }
}
