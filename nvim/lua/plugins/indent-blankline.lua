return {
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    require('ibl').setup {
      indent = {
        char = ' ',
      },
      scope = {
        char = '│',
        show_end = false,
        show_start = false,
      }
    }
  end
}
