return {
  'ray-x/lsp_signature.nvim',
  event = 'InsertEnter',
  config = function()
    require('lsp_signature').setup({
      bind = true,
      hint_enable = false,
    })
  end
}
