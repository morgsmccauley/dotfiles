return {
  'catppuccin/nvim',
  name = 'catppuccin',
  build = ':CatppuccinCompile',
  config = function()
    require('catppuccin').setup({
      term_colors = true,
      compile = {
        enabled = true,
        path = vim.fn.stdpath 'cache' .. '/catppuccin'
      },
      integrations = {
        leap = true,
        telescope = true,
        mason = true,
        neotest = true,
        nvimtree = {
          transparent_panel = true,
        },
        navic = {
          enabled = true,
        },
        dap = {
          enabled = true,
          enable_ui = true
        },
        native_lsp = {
          enabled = true
        },
      },
      flavour = 'macchiato', -- latte, frappe, macchiato, mocha
    })

    vim.api.nvim_command [[colorscheme catppuccin]]
  end
}
