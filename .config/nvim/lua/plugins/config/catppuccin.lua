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
      IlluminatedWordText = { link = 'Visual' },
      IlluminatedWordRead = { link = 'Visual' },
      IlluminatedWordWrite = { link = 'Visual' },

      TreesitterContext = { link = 'CursorLine' }
    }
  end
})

vim.api.nvim_command [[colorscheme catppuccin]]
