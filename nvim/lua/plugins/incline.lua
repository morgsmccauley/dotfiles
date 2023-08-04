return {
  'b0o/incline.nvim',
  event = 'VeryLazy',
  enabled = false,
  config = function()
    require('incline').setup({
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
        local icon, color = require('nvim-web-devicons').get_icon_color(filename)
        return {
          { icon,    guifg = color },
          { ' ' },
          { filename },
        }
      end,
      window = {
        margin = {
          horizontal = 0
        }
      },
      hide = {
        only_win = true
      }
    })
  end
}
