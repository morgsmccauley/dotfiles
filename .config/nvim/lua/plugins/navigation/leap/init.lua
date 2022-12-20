return {
  'ggandor/leap.nvim',
  keys = { 's', 'S', 'f', 'F', 't', 'T' },
  config = function()
    require('plugins.navigation.leap.leap')
  end
}
