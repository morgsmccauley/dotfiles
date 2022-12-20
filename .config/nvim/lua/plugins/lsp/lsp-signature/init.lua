return {
  'ray-x/lsp_signature.nvim',
  event = 'InsertEnter',
  config = function()
    require('plugins.lsp.lsp-signature.lsp-signature')
  end
}
