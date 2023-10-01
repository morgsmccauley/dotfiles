return {
  init = function()
    vim.api.nvim_set_hl(0, 'IblScope', { link = 'IblIndent' })
  end,
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    require('ibl').setup {
      indent = {
        char = ' ',
      },
      scope = {
        char = '⎸',
        show_end = false,
        show_start = false,
      }
    }
  end
}
