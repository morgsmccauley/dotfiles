return {
  'kyazdani42/nvim-tree.lua',
  cmd = { 'NvimTreeFindFileToggle' },
  config = function()
    require('plugins.navigation.nvim-tree.nvim-tree')
  end
}
