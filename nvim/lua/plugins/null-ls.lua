return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = {
    'jay-babu/mason-null-ls.nvim',
  },
  config = function()
    local null_ls = require('null-ls')
    require('null-ls').setup({
      sources = {
        null_ls.builtins.formatting.jq,
        null_ls.builtins.formatting.prettierd,
      }
    })
    require('mason-null-ls').setup({
      automatic_installation = {
        exclude = { 'jq' }
      },
      -- automatic_setup = true,
    })
  end
}
