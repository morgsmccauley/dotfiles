return {
  'catppuccin/nvim',
  name = 'catppuccin',
  build = ':CatppuccinCompile',
  config = function()
    require('catppuccin').setup({
      highlight_overrides = {
        all = function()
          return {
            DiagnosticVirtualTextError = { bg = 'NONE' },
            DiagnosticVirtualTextWarn = { bg = 'NONE' },
            DiagnosticVirtualTextInfo = { bg = 'NONE' },
            DiagnosticVirtualTextHint = { bg = 'NONE' },
            IblScope = { link = 'IblIndent' },
          }
        end
      },
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
        neogit = true,
        gitsigns = true,
        symbols_outline = true,
        illuminate = true,
        markdown = true,
        cmp = true,
        treesitter = true,
        octo = true,
        which_key = true,
        indent_blankline = {
          enabled = true
        },
        nvimtree = {
          transparent_panel = true,
        },
        dap = {
          enabled = true,
          enable_ui = true
        },
        native_lsp = {
          enabled = true
        },
      },
      flavour = vim.fn.system('defaults read -g AppleInterfaceStyle') == 'Dark\n' and 'macchiato' or 'latte'
    })

    vim.api.nvim_command [[colorscheme catppuccin]]
  end
}
