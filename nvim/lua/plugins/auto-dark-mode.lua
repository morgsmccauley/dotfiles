return {
  'f-person/auto-dark-mode.nvim',
  enabled = false,
  config = function()
    local auto_dark_mode = require('auto-dark-mode')

    auto_dark_mode.setup({
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option('background', 'light')
        vim.cmd('Catppuccin macchiato')
      end,
      set_light_mode = function()
        vim.api.nvim_set_option('background', 'dark')
        vim.cmd('Catppuccin latte')
      end,
    })

    auto_dark_mode.init()
  end
}
