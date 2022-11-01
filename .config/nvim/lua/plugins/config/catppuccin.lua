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
  custom_highlights = function()
    return {
      IlluminatedWordText = { underline = true },
      IlluminatedWordRead = { underline = true },
      IlluminatedWordWrite = { underline = true },

      TreesitterContext = { link = 'Visual' }
    }
  end
})

vim.api.nvim_command [[colorscheme catppuccin]]
