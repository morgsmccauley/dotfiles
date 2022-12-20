return {
  'ggandor/flit.nvim',
  after = 'leap.nvim',
  config = function()
    require('plugins.navigation.filt.filt')
  end
}
