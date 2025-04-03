return {
  'pwntester/octo.nvim',
  cmd = 'Octo',
  config = function()
    require 'octo'.setup({
      mappings_disable_default = true
    })
  end
}
