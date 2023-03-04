return {
  'b0o/incline.nvim',
  event = 'VeryLazy',
  config = function()
    require('incline').setup({
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
