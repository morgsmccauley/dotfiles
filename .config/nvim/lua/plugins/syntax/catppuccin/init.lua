return {
  'catppuccin/nvim',
  as = 'catppuccin',
  run = ':CatppuccinCompile',
  config = function()
    require('plugins.syntax.catppuccin.catppuccin')
  end
}
