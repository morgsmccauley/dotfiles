return {
  'catppuccin/nvim',
  as = 'catppuccin',
  run = ':CatppuccinCompile',
  config = function()
    require('catppuccin').setup({
      term_colors = true,
      compile = {
        enabled = true,
        path = vim.fn.stdpath 'cache' .. '/catppuccin'
      },
      integrations = {
        leap = true,
        nvimtree = {
          transparent_panel = true,
        },
      },
      flavour = 'macchiato', -- latte, frappe, macchiato, mocha
    })

    -- vim.api.nvim_command [[colorscheme catppuccin]]
  end
}
